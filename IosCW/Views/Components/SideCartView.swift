//
//  SideCartView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-24.
//

import SwiftUI

struct SideCartViewTemp: View {
   @State var presentCartShowMenu = true
 
    var body: some View {
        VStack(alignment: .leading){
            SideCartMenu()
        }
    }
    
    @ViewBuilder
    private func SideCartMenu() -> some View {
        SideView(isShowing: $presentCartShowMenu, content: AnyView(SideCartViewContents(presentSideMenu: $presentCartShowMenu)), direction: Edge.trailing)
    }
}

struct SideCartView_Previews: PreviewProvider {
  static  var previews:  some View {
      SideCartViewTemp()
    }
}

struct SideCartViewContents : View {
    @Binding var presentSideMenu :Bool
    @State private var totalPrice : Double = 0
    @StateObject var productVM = ProductViewModel()
    @State private var cartItems: [CartItem]=[]
    var body: some View {
        VStack(alignment: .leading){
            SideMenuTopView()
                .padding([.leading,.trailing],20)
            Text("CART")
                .foregroundColor(.black)
                .padding([.leading,.trailing],20)
            
            if ((cartItems.isEmpty) != nil) {
                CartFullView()
            } else {
               
            
            }
 
            Spacer()
            NavigationLink(destination: PlaceOrderView(cartItems: cartItems, totalPrice: totalPrice, discount: 0)) {
                         HStack {
                             Image(systemName: "cart")
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(width: 20, height: 20)
                                 .colorInvert()
                             Text("Continue Shopping")
                                 .font(.system(size: 16))
                                 .multilineTextAlignment(.center)
                                 .foregroundColor(.white)
                         }
                         .frame(height: 86)
                         .frame(maxWidth: .infinity)
                         .background(Color.black)
                     }
        }
        .onAppear{
    
            Task {
                           await getCartDetails()
                updateCartValue()
                       }
           
        }
        
    }
    
    func getCartDetails() async {
            // Call the view model function to get cart details
            do {
             cartItems = try await productVM.getCartDetails33(for: "123")
                    // Update the @State variable to trigger view update
                    self.cartItems = cartItems
                updateCartValue()
                
            } catch {
                // Handle error
                print("Error fetching cart details: \(error)")
            }
        }
    
    @ViewBuilder
    func SideMenuTopView() -> some View{
        VStack{
            HStack{
                Button{
                  presentSideMenu.toggle()
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                        .padding(.trailing, 20)
                }
                .frame(width: 34, height: 34)
                Spacer()
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.leading,10)
        .padding(.top,40)
        .padding(.bottom,30)
    }
    
    @ViewBuilder
    func EmpttyCartView() -> some View {
        VStack (alignment : .leading){
            Text("You have no items in your cart ")
        }
    }
    
    @ViewBuilder
    func CartFullView() -> some View {
        VStack (alignment : .leading){
            ScrollView(.vertical){
                ForEach(0..<cartItems.count,id: \.self){ i in
                    if cartItems[i].qty > 0 {
                        CartItemView(item: cartItems[i] ){
                            updateCartValue()
                        }
                    }
                }
            }.padding([.leading,.trailing])
            
            VStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 1)
                HStack{
                    Text("SUB TOTAL")
                        .font(.system(size: 14))
                    Spacer()
                    Text(String(format: "RS %.2f", totalPrice))
                        .font(.system(size: 18))
                }
                .padding([.leading,.trailing],20)
                Text("* Shipping chargers , taxes and discounts codes are calculated at the time of accounting..")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                    .frame(height: 72,alignment: .top)
                    .padding([.leading,.trailing])
            }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
    func updateCartValue(){
        var value: Double = 0
        if cartItems.isEmpty{
            
        }else{
            for item in cartItems{
                value += (Double(item.qty) * item.product.price)
            }
            totalPrice = value
        }
       
      
    }
    
    func updateAddCartValue(){
        var value: Double = 0
        if cartItems.isEmpty{
            
        }else{
            for item in cartItems{
                value += (Double(item.qty) * item.product.price)
            }
            totalPrice = value
        }
       
      
    }
}
