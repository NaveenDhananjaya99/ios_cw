//
//  HeaderView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-20.
//

import SwiftUI

struct HeaderView: View {
    var menuAction : ButtonAction
    var cartAction : ButtonAction
    var favAction : ButtonAction
    @StateObject var productVM = ProductViewModel()
       @State private var cartItems = [CartItem]()
    @State var cartProductCount = 3
    @State var favoriteProductCount = 1
    
    var body: some View {
        ZStack {
            HStack {
                // Menu Icon
                Button(action: {
                    menuAction()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
                //                .padding(.vertical, 8)
                
                Spacer()
                
                // Logo
                Text("DEC 2 ONE")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding([.leading, .trailing])
                
                
                
//                // Favorite Icon with count
//                Button(action: {
//                    favAction()
//                }) {
//                    ZStack {
//                        Image(systemName: "heart")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 24, height: 24)
//                            .foregroundColor(.black)
//                        
//                        // Red circle with value
//                        Circle()
//                            .foregroundColor(.red)
//                            .frame(width: 20, height: 20)
//                            .overlay(
//                                Text("\(favoriteProductCount)")
//                                    .foregroundColor(.white)
//                                    .font(.caption)
//                            )
//                            .offset(x: 15, y: -8) // Offset to position the circle on top of the icon
//                    }.padding([.leading, .trailing])
//                }
//                
                
                // Shopping Cart Icon with count
                Button(action: {
                    cartAction()
                }) {
                    ZStack {
                        Image(systemName: "cart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                        
                        // Red circle with value
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Text("\(cartProductCount)")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            )
                            .offset(x: 15, y: -8) // Offset to position the circle on top of the icon
                    }.padding([.leading, .trailing])
                }.onAppear {
                    // Fetch cart details when the view appears
                    getCartDetails()
                }
                
                
            }.padding([.leading, .trailing])
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(Color.white)
        .zIndex(1)
        .shadow(radius: 0.4)
        
        
    }
    
    func getCartDetails() {
           // Call the view model function to get cart details
           Task {
               do {
                   let fetchedCartItems = try await productVM.getCartDetails33(for: "123")
                   // Update the @State variable to trigger view update
                   self.cartItems = fetchedCartItems
                   self.cartProductCount = fetchedCartItems.count
               } catch {
                   // Handle error
                   print("Error fetching cart details: \(error)")
               }
           }
       }
    
}
