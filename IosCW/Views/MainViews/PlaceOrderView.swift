import SwiftUI

struct PlaceOrderView: View {
    @State private var receiverName = ""
    @State private var receivermobile = ""
    @State private var address = ""
    @State private var isOrderPlaced = false
    @State private var navigateToHome = false
    let cartItems: [CartItem]
    let totalPrice: Double
    let discount: Double

    var body: some View {
        NavigationView{
            VStack {
                // Product List
                List(cartItems, id: \.id) { item in
                    HStack {
                        // Display product image
                        AsyncImage(url: URL(string: item.product.productImages.first?.imageName ?? "")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50) // Adjust size as needed
                            case .failure(let error):
                                // Placeholder image or error handling
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50) // Adjust size as needed
                            case .empty:
                                // Placeholder image or loading indicator
                                ProgressView()
                                    .frame(width: 50, height: 50) // Adjust size as needed
                            }
                        }
                        
                        // Display product name and quantity
                        VStack(alignment: .leading) {
                            Text(item.product.name)
                                .font(.headline)
                            Text("Qty: \(item.qty) x \(String(format: "%.2f", item.product.price))")

                                .font(.subheadline)
                        }
                    }
                }
                .padding()
                
                // Total Price Section
                HStack {
                    Text("Total Price: Rs\(String(format: "%.2f", totalPrice))")
                    Spacer()
                }
                .padding()
                
                // Discount Section
                HStack {
                  
                    Text("Discount: Rs\(String(format: "%.2f", discount))")
                    Spacer()
                }
                .padding()
                
                HStack{
                    Text("Receiver's Name")
                    TextField("Receiver's Name", text: $receiverName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
              
                HStack{
                    Text("Receiver's Mobile number")
                    TextField("Receiver's Mobile number", text: $receivermobile)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
              
                
                HStack{
                    Text("Address")
                    TextField("Address", text: $address)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
              
                // Place Order Button
                Button(action: {
                    // Call a function to submit the order with receiverName and address
                    placeOrder()
                }) {
                    Text("Place Order")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $isOrderPlaced) {
                                Alert(title: Text("Order Placed"), message: Text("Your order has been successfully placed."), dismissButton: .default(Text("OK")) {
                                    // Navigate to home page after dismissing the alert
                                    navigateToHome = true
                                })
                            }
                          
            }
            .padding()
        } .background(
                    NavigationLink(
                        destination: HomeView(), // Replace HomePage with your actual home page view
                        isActive: $navigateToHome,
                        label: { EmptyView() }
                    )
                    .hidden()
                )
    }

    func placeOrder() {
        // Perform actions to place the order using receiverName and address
        // Once the order is successfully placed, set isOrderPlaced to true to show the alert
        isOrderPlaced = true
    }
}

//struct PlaceOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Sample cart items for preview
//        let sampleCartItems = [
//            CartItem(product: Product(id: 1, name: "Product 1", price: 10.0), qty: 2, userId: "123", productId: 1, id: 1),
//            CartItem(product: Product(id: 2, name: "Product 2", price: 15.0), qty: 1, userId: "123", productId: 2, id: 2)
//        ]
//        // Sample total price and discount for preview
//        let sampleTotalPrice = 35.0
//        let sampleDiscount = 5.0
//
//        return PlaceOrderView(cartItems: sampleCartItems, totalPrice: sampleTotalPrice, discount: sampleDiscount)
//    }
//}
