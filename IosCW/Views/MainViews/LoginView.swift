import SwiftUI



struct LoginPage: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var userName = ""
    @State private var password = ""
    @State private var token: String? = nil
    @State private var isPasswordVisible = false
    @State private var navigateToHome = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack {
//             Text("WELCOME").font(.largeTitle).padding(.bottom, 30)
//                Spacer()
                           
                           Image("logo")
                               .resizable()
                               .scaledToFit()
                               .frame(height: 250)
                               .padding()
                               .padding(.top,30)
                           
                TextField("Email", text: $userName)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding([.horizontal, .bottom])
                
                HStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding([.horizontal, .bottom])
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding([.horizontal, .bottom])
                    }
                    
                    // Button to toggle password visibility
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
                
                Button(action: {
                    
                  loginViewModel.loginUser(userName: userName, password: password)
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        // Navigate to registration page
                        print("Register pressed")
                    }) {
                        Text("Register")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .navigationTitle("Login")
                       .navigationBarHidden(true)
                       .background(
                           NavigationLink(
                               destination: HomeView(),
                               isActive: $loginViewModel.isLoggedIn,
                               label: { EmptyView() }
                           )
                           .hidden()
                       )
        }
        .alert(isPresented: Binding<Bool>(
                   get: { loginViewModel.errorMessage != nil },
                   set: { _ in loginViewModel.errorMessage = nil })
               ) {
                   Alert(title: Text("Error"), message: Text(loginViewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
               }
               .onReceive(loginViewModel.$isLoggedIn) { loggedIn in
                   if loggedIn {
                       self.presentationMode.wrappedValue.dismiss()

                   navigateToHome = true
                   }
               }
    }
    
   
}
