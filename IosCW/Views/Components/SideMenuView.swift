import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if isShowing {
                Color.white.opacity(0.7) // Semi-transparent background
                    .ignoresSafeArea()
               
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                                         Text("DEC 2 ONE")
                                             .font(.title)
                                             .fontWeight(.bold)
                                             .padding(.leading, 30)
                                         
                                         Spacer()
                                         
                                         Button(action: {
                                             isShowing.toggle()
                                         }) {
                                             Image(systemName: "xmark.circle.fill")
                                                 .font(.title)
                                                 .foregroundColor(.blue)
                                                 .padding(.trailing, 20)
                                         }
                                     }
//                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                        .padding(.top,30)
                    // Profile Section
                    SideMenuRow(imageName: "person.circle", text: "Profile") {
                        // Action for profile
                    }
                    
                    // Orders Section
                    SideMenuRow(imageName: "bag.circle", text: "Orders") {
                        // Action for orders
                    }
                    
                    // Favorites Section
                    SideMenuRow(imageName: "heart.circle", text: "Favorites") {
                        // Action for favorites
                    }
                    
                    // Settings Section
                    SideMenuRow(imageName: "gearshape", text: "Settings") {
                        // Action for settings
                    }
                    SideMenuRow(imageName: "arrow", text: "LogOut") {
                    
                    }
                    
                    Spacer()
                }
//                .padding(.vertical)
//                .padding(.leading, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .shadow(radius: 5)
                .offset(x: 0, y: 50) // Adjust the sidebar position
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut)
    }
}

struct SideMenuRow: View {
    var imageName: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: imageName)
                    .font(.title)
                    .foregroundColor(.black)
                
                Text(text)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
    }
}
