//
//  ProductsList.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-24.
//

import SwiftUI

struct ProductsList: View {
    
   @State var presentSideBarMenu = false
   @State var presentCart = false
    @StateObject var productVM = ProductViewModel()
    @State private var searchText = ""
    private let adapriveColoumn = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {

        ZStack{
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ZStack{
                VStack(spacing: 0){
                    HStack{
                        Text("PRODUCTS")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding()
                    SearchBar(text: $searchText, searchAction: search)
                        .padding(.horizontal)
                    Spacer()
                    ScrollView(.vertical){
                        
                        VStack{
                            
                            ScrollView(.vertical){
                                LazyVGrid(columns:adapriveColoumn
                                ){

                                    ForEach(productVM.productData, id: \.id) { product in
                                               ProductView(products: product)
                                           }
                                  
                                }.onAppear {
                                    Task {
                                        await productVM.fetchData()
                                    }
                                }
                            }.scrollIndicators(.hidden)
                        }.padding([.leading,.trailing],20)
                        
                        FooterView()
                    }
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                  
                }
                .padding(.top,76)
               
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
        }.navigationBarTitleDisplayMode(.inline)
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
    
    func search(name: String) {
         // Call the search function from your ProductViewModel
         Task {
             await productVM.search(name: name)
         
         }
     }
}

struct SearchBar: View {
    @Binding var text: String
    @State private var isFiltering = false
    @State private var minPrice: Double = 0
       @State private var maxPrice: Double = 6000
    var searchAction: (String) -> Void
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
              
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.trailing, 8)
                .onChange(of: text) { newText in
                                    // Call your function here, passing newText if needed
                                    // For example:
                                    print("Text changed to: \(newText)")
                                    // Call your function here
                                    // functionName()
                    searchAction(text)
                    
                                }
            
         
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
            
            Button(action: {
                      isFiltering.toggle()
                  }) {
                      Image(systemName: "slider.horizontal.3")
                          .foregroundColor(.gray)
                          .padding(.trailing, 8)
                  }
      
        }
        HStack{
            
            if isFiltering {
                VStack {  Text("Filters")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.bottom)
                        .padding(.top)
                    VStack {
                        Text("Price Range")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom)
                            .padding(.top)
                        
                        HStack {
                            Text("Min")
                            Text(String(format: "%.2f", minPrice))
                            Spacer()
                            Text("Max")
                            Text(String(format: "%.2f", maxPrice))
                        }
                        .padding(.horizontal)
                        HStack {
                            Slider(value: $minPrice, in: 0...1000, step: 1)
                            Slider(value: $maxPrice, in: 0...1000, step: 1)
                        }
                        .padding(.horizontal)
                       
                        
                        
                        
                    }
                    Divider()
                
                    
                    Button(action: {
                        isFiltering=false
                    }) {
                        Text("Apply")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }  .padding(.bottom)
                }
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(.trailing, 10)
                .padding(.top, 50)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
            
        }.padding(.bottom, 20)

    }
}
#Preview {
    ProductsList()
}
