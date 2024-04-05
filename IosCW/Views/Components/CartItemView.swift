//
//  CartItemView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-24.
//

import SwiftUI

struct CartItemView: View {
    @State var item : CartItem
    var onCartCountValueChanged: () -> ()
    var body: some View {
        ZStack{
            HStack(spacing : 20){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 100 , height: 133)
                    .background(
//                        Image(item.product.productImages[0].imageName)
//                            .resizable()
//                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 133)
//                            .clipped()
//                        
                        AsyncImage(url: URL(string: item.product.productImages[0].imageName)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 133)
                                    .clipped()

                            case .failure(let error):
                                // Placeholder image or error handling
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 133)
                                    .clipped()

                                // Print or handle the error
                              
                            case .empty:
                                // Placeholder image or loading indicator
                                ProgressView()
                                    .frame(width: 165, height: 200)
                                    .cornerRadius(5)
                                    .shadow(radius: 2)
                        
                            }
                        }
                    )
                VStack (alignment : .leading){
                    Text("\(item.product.name)")
                    HStack(spacing: 20 ){
                        Button{
                            item.qty -= 1
                            if item.qty < 0 {
                                item.qty = 0
                            }
                            onCartCountValueChanged()
                        }label: {
                            Circle()
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                                .overlay{
                                    Image(systemName: "minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .tint(.black)
                                        .frame(width: 14,height: 14)
                                     
                                       
                                }
                        }
                        .frame(width: 24,height:24)
                        
                        Text("\(item.qty)")
                            .font(.system(size: 24))
                         
                            
                        Button{
                            item.qty = item.qty+1
                            if item.qty < 0 {
                                item.qty = 0
                            }
                            onCartCountValueChanged()
                        }label: {
                            Circle()
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                                .overlay{
                                    Image(systemName: "plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .tint(.black)
                                        .frame(width: 14,height: 14)
                                     
                                       
                                }
                        } .frame(width: 24,height:24)
                        
                    }
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    CartItemView(item: .init(product: product1, count: 1)) {
//        
//    }
//}
