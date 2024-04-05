import SwiftUI

struct SpalshScreen: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isLoading = true // To control spinner visibility
    @State var isPresenting = false
    @State var isLogin = false
    var body: some View {
        NavigationView {
        ZStack {
            Color.green // Background color
                .ignoresSafeArea()
         
            VStack {
                
                ProgressView() // Spinner
                    .padding()
                Text("DEC 2 ONE").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .onAppear {
                        // Simulate a delay to show spinner for a moment
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            
                           isLogin = true /*print(loginViewModel.getTokenFromKeychain() ?? "xvx")*/
//                            if loginViewModel.getTokenFromKeychain() != nil {
//                                
//                             isPresenting = true
//                                isLogin = false
//                            } else {
//                                isPresenting = false
//                                print("hom2r")
//                               isLogin = true
//                            }
                        }
                    }
                
            }
     
                       .navigationBarHidden(false)
                       .background(
                           NavigationLink(
                               destination: HomeView(),
                               isActive: $isPresenting,
                               label: { EmptyView() }
                           )
                           .hidden()
                       )
            
                                  .navigationBarHidden(false)
                                  .background(
                                      NavigationLink(
                                          destination:LoginPage(),
                                          isActive: $isLogin,
                                          label: { EmptyView() }
                                      )
                                      .hidden()
                                  )
        }
    }
    }
}

struct SpalshScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpalshScreen()
    }
}
