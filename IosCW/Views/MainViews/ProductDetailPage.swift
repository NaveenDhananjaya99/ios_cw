//
//  ProductDetailPage.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-24.
//

import SwiftUI

struct ProductDetailPage: View {
    @State var presentSideBarMenu = false
    @State var presentCart = false
    @State var isShowingQuantityPopover = false
       @State var quantity: Int = 1
    @State private var selectedSize = "S"

    var product : Product
     
     var body: some View {
         ZStack{
             Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
             ZStack{
                 VStack(spacing: 0){
                     ScrollView{
                         TabView {
                             ForEach(product.productImages.indices, id: \.self) { i in
                              
                                     
                                 
                                 AsyncImage(url: URL(string: product.productImages[i].imageName)) { phase in
                                     switch phase {
                                     case .success(let image):
                                         image
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(height: 500)
                                             .clipped()
                                     case .failure(let error):
                                         // Placeholder image or error handling
                                         Image(systemName: "photo")
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .frame(height: 500)
                                             .clipped()
                                       
                                     case .empty:
                                         // Placeholder image or loading indicator
                                         ProgressView()
                                             .frame(width: 165, height: 200)
                                             .cornerRadius(5)
                                             .shadow(radius: 2)
                                     }
                                 }

                             }
                         }.tabViewStyle(.page)
                             .indexViewStyle(
                                .page(backgroundDisplayMode: .always)
                             )
                             .frame(height: 500)
                             .padding([.leading,.trailing],20)
                        
                         VStack(alignment: .leading){
                             HStack(alignment: .top){
                                 Text(product.name)
                                     .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                     .foregroundColor(.black)
                                     .padding([.leading,.trailing],20)
                                 Spacer()
                                 VStack(spacing: 0) {
                                                // Your existing code...
                                                Button(action: {
                                                    isShowingQuantityPopover = true
                                                }) {
                                                    Image(systemName: "cart")
                                                        .resizable()
                                                        .foregroundColor(.black)
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 20,height: 20)
                                                        .padding([.leading,.trailing],20)
                                                }
                                            }
                                           
                                            .popover(isPresented: $isShowingQuantityPopover, content: {
                                                QuantityPopover(quantity: $quantity,product:product)
                                            })
                                
                                 
                             }
                             
                             
                             Text("RS \(String(format: "%.2f", product.price))")
                                     .font(.headline)
                                     .foregroundColor(.black)
                                     .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                     .frame(width: 165,alignment: .leading)

                                     .padding([.leading,.trailing],20)
                             Picker("Size", selection: $selectedSize) {
                                        Text("S").tag("S")
                                        Text("M").tag("M")
                                        Text("L").tag("L")
                                        Text("XL").tag("XL")
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .padding()
                             Text("DESCRIPTION")
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.black)
                                                        .padding(.horizontal, 20)
                                                        .padding(.top, 10)
                                                    
                                                    Text(product.description)
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                        .padding(.horizontal, 20)
                         }
                     }
                     
                 }.padding(.top,56)
             }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                 .overlay(alignment: .top) {
                     HeaderView{
                         presentSideBarMenu.toggle()
                 }cartAction: {
                     presentCart.toggle()
                     
                 }favAction: {
                     print("aaa")
                 }
                 }
            
             sideBarView()
             cartView()
         }
     }
     
     @ViewBuilder
     private func HeroSlider() -> some View {
         ZStack {
             Image("heroImage2")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(maxWidth: .infinity)
                 .frame(height: 620)
             
             VStack {
                 Spacer()
                
                 Text("DEC 2 ONE CLOTHING ")
                     .font(.largeTitle)
                     .fontWeight(.bold)
                     .frame(width: .infinity)
                     .foregroundColor(.white)
                     .padding()
                     .background(Color.black.opacity(0.3))
                     .cornerRadius(10)
                     .padding(.bottom, 60).multilineTextAlignment(.center)
                    
           
     //            Text("Fashion Central")
     //                .font(.title)
     //                .fontWeight(.semibold)
     //                .foregroundColor(.white)
     //
     //                .padding()
     //                .background(Color.black.opacity(0.3))
     //                .cornerRadius(10)
     //                .padding(.bottom, 20)
     //
                 Button{
                     print("Discover more ")
                 }label: {
                     Text("Discover Your Style >")
                         .font(.title)
                         .fontWeight(.bold)
                         .foregroundColor(.white)
                         .padding()
                         .background(Color.green.opacity(0.8))
                         .cornerRadius(10)
                         .padding(.bottom, 100)
                         .multilineTextAlignment(.center) // Center align the text
                 }
                 .padding(.horizontal, 20)
                 }
                // Add horizontal padding to the VStack
         }
     }
     @ViewBuilder
     private func sideBarView() -> some View {
         SideMenuView(isShowing: $presentSideBarMenu)
     }
     
     @ViewBuilder
     private func cartView() -> some View {
         SideView(isShowing: $presentCart, content: AnyView(SideCartViewContents(presentSideMenu:$presentCart)), direction: Edge.trailing)
     }
}
struct QuantityPopover: View {
    @Binding var quantity: Int
   var product: Product
    @State private var addToCartResult: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var productVM = ProductViewModel()
    var totalPrice: Double {
        Double(quantity) * product.price
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.productImages[0].imageName)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 500)
                        .clipped()
                case .failure(let error):
                    // Placeholder image or error handling
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 500)
                        .clipped()
                  
                case .empty:
                    // Placeholder image or loading indicator
                    ProgressView()
                        .frame(width: 165, height: 200)
                        .cornerRadius(5)
                        .shadow(radius: 2)
                }
            }
            // Display price and total price
            Text("Price: $\(String(format: "%.2f", product.price))")
                .padding(.bottom, 10)
            
            Text("Total Price: $\(String(format: "%.2f", totalPrice))")
                .padding(.bottom, 10)
            
            // Stepper for quantity selection
            Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                .padding()
            
            // Add to cart button
            Button(action:  {
                Task {
                      
                       addToCartResult = await productVM.addToCart(userId: "123", productId: product.id, quantity: quantity)
                   }
            }) {
                Text("Add to Cart")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $addToCartResult) {
                           if addToCartResult {
                               return Alert(title: Text("Success"), message: Text("Product added to cart successfully."), dismissButton: .default(Text("OK")) {
                                   
                                                 presentationMode.wrappedValue.dismiss()
                                         
                               })
                           } else {
                               return Alert(title: Text("Error"), message: Text("Failed to add product to cart."), dismissButton: .default(Text("OK")))
                           }
                       }
            NavigationLink(
                                                  destination: ProductsList(), // Your product list view
                                                  isActive: $addToCartResult,
                                                  label: { EmptyView() }
                                              )
                                              .hidden()
        }
        .padding()
     
    }
}
