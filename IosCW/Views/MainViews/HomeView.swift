//
//  HomeView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-20.
//

import SwiftUI

struct HomeView: View {
    @StateObject var productVM = ProductViewModel()
   @State var presentSideBarMenu = false
   @State var presentCart = false
    private let adapriveColoumn = [GridItem(.adaptive(minimum: 150))]
    
    private var categories = [Categories.All.rawValue,Categories.TShirt.rawValue,Categories.Bag.rawValue,Categories.Apperel.rawValue,Categories.Dress.rawValue,]
    
    @State private var selectedCategory : Int = 0
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ZStack{
                VStack(spacing: 0, content: {
                    ScrollView(.vertical){
                        HeroSlider().onTapGesture {
                        print("tapped")
                        }
                        FeaturedProductSlider()
                        CollectionView()
                        FooterView()
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }).padding(.top,10)
               
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
        
        .navigationBarHidden(true)
        
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
                NavigationLink(destination: ProductsList()) {
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
                .padding(.horizontal, 20)
                }
               // Add horizontal padding to the VStack
        }
    }
    @ViewBuilder
    private func FeaturedProductSlider() -> some View {
        Text("Featured Products ").font(.largeTitle).multilineTextAlignment(.center).foregroundColor(.black).fontWeight(.bold).frame(height: 32,alignment: .top)
        Image("devider")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(width: 225)
            .padding(.top, -50)
        VStack{
            HStack(spacing: 20){
                ForEach(0..<categories.count,id: \.self){i in
                    CategoryView(isSelected: i == selectedCategory,
                                 title: categories[i]).onTapGesture {
                        selectedCategory =  i
                    }
                
                    
                }
            } .padding(.top, -50).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
//            HStack{
//                ProductView(products: product1)
//                ProductView(products: product2)
//            }
//            HStack{
//                ProductView(products: product3)
//                ProductView(products: product4)
//            }
            
//            LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)], spacing: 20) {
//                    ForEach(productVM.productData, id: \.id) { product in
//                        ProductView(products: product)
//                    }
//                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
//                  
//             
            
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
            }.padding([.leading,.trailing],5)
            
          
            
            NavigationLink(destination: ProductsList()) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8){
                    Text("Expore More").multilineTextAlignment(.center)
                    
                    Image(systemName: "arrow.forward").frame(width: 18,height: 18)
                }
            }.tint(Color.black)
                .padding(12)
        }
    }
    
    @ViewBuilder
    private func CollectionView() -> some View{
        Text("Collections")
            .foregroundColor(Color.black)
            .font(.largeTitle).multilineTextAlignment(.center).foregroundColor(.black).fontWeight(.bold).frame(height: 32,alignment: .top).padding(.top,30)
        Image("devider")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(width: 225)
            .padding(.top, -50)
        Image("sk1")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(height: 244, alignment: .top)
            .clipped()
            .frame(width: 225)
        Image("aa1")
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(height: 244, alignment: .top)
            .clipped()
            .frame(width: 225)
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

#Preview {
    HomeView()
}
