//
//  ProductView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-21.
//

import SwiftUI

struct ProductView: View {
    var products : Product
    var body: some View {
        
        //            Button{
        //             print("ciclk")
        //            }label: {
        //                VStack{
        //                    if let firstImage = products.productImages.first {
        //                        Image(firstImage.imageName)
        //                                       .resizable()
        //                                       .aspectRatio(contentMode: .fill)
        //                                       .frame(width: 165, height: 200)
        //                                       .cornerRadius(5)
        //                                       .shadow(radius: 2)
        //                               } else {
        //                                   // Provide a default image or placeholder if productImages is empty
        //                                   Image(systemName: "photo")
        //                                       .resizable()
        //                                       .aspectRatio(contentMode: .fill)
        //                                       .frame(width: 165, height: 200)
        //                                       .cornerRadius(5)
        //                                       .shadow(radius: 2)
        //                               }
        //                Text(products.name).font(.headline)
        //                    .multilineTextAlignment(.leading)
        //                    .foregroundColor(.gray)
        //                    .frame(width: 165 , alignment: .top)
        //
        //                Text("RS \(String(format: "%.2f", products.price))")
        //                        .font(.headline)
        //                        .foregroundColor(.black)
        //                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
        //                        .frame(width: 165,alignment: .leading)
        //                        .padding(.top,2)
        //            }
        //
        //        }
        //    }
        
        
        NavigationLink(destination: ProductDetailPage(product: products)) {
            VStack{
                if let firstImage =  products.productImages.first {
                    AsyncImage(url: URL(string: firstImage.imageName)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 165, height: 200)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                        case .failure(let error):
                            // Placeholder image or error handling
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 165, height: 200)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                            // Print or handle the error
                          
                        case .empty:
                            // Placeholder image or loading indicator
                            ProgressView()
                                .frame(width: 165, height: 200)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                        }
                    }

                } else {
                    // Provide a default image or placeholder if productImages is empty
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 165, height: 200)
                        .cornerRadius(5)
                        .shadow(radius: 2)
                }
                Text(products.name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .frame(width: 165 , alignment: .top)
                
                Text("RS \(String(format: "%.2f", products.price))")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(width: 165,alignment: .leading)
                    .padding(.top,2)
            }
        }
        
    }
}
//#Preview {
//    ProductView(products: product1)
//}
