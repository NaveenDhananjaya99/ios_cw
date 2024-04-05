//
//  ProductViewModel.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-27.
//

import Foundation

@MainActor class ProductViewModel: ObservableObject {
    @Published var productData = [Product]()
    
    func fetchData() async {
        guard let token = LoginViewModel().getTokenFromKeychain() else {
            print("Token not found")
            return
        }
        do {
            print(token)
            if let responseProduct = try await WebService().getData(fromURL: "https://dec2one.firesvlk.online:8443/api/v1/products", token: token) {
                productData = responseProduct
                print(productData)
            }
        } catch {
            var token = LoginViewModel().getTokenFromKeychain()
            var loginViewModel = LoginViewModel()
            if let errorDescription = error.localizedDescription as? String, errorDescription.contains("401") {
                // Trigger auto-login process
//                let username = UserDefaults.standard.string(forKey: "username")
//                let password = UserDefaults.standard.string(forKey: "password")
//                if let username = username, let password = password {
//                    do {
//                        loginViewModel.loginUser(userName: username, password: password)
//                      await  fetchData()
//                    } catch {
//                        print("Error logging in: \(error)")
//                        return
//                    }
//                   
//                } else {
//                    print("Error fetching data: \(error)")
//                }
                
                print("un autho")
            }
            
        }
    }
    
    func search(name: String) async {
        guard let token = LoginViewModel().getTokenFromKeychain() else {
            print("Token not found")
            return
        }
        do {
            if let responseData = try await WebService().getData(fromURL: "https://dec2one.firesvlk.online:8443/api/v1/products/search-by-name?name=\(name)", token: token) {
                if let responseDictionary = responseData as? [String: Any], let products = responseDictionary["products"] as? [[String: Any]] {
                    // Decode products array
                    let jsonData = try JSONSerialization.data(withJSONObject: products, options: [])
                    let decoder = JSONDecoder()
                    productData = try decoder.decode([Product].self, from: jsonData)
                    print(productData)
                } else {
                    print("Error: Unexpected response format")
                }
            }
        } catch {
            var token = LoginViewModel().getTokenFromKeychain()
            var loginViewModel = LoginViewModel()
            if let errorDescription = error.localizedDescription as? String, errorDescription.contains("401") {
                // Trigger auto-login process
                print("un autho")
            }
        }
    }
    
    
    func addToCart(userId: String, productId: Int, quantity: Int) async -> Bool {
          guard let token = LoginViewModel().getTokenFromKeychain() else {
              print("Token not found")
             return false
          }
          print (userId)
          print (productId)
          print (quantity)
          let body: [String: Any] = [
              "user_id": userId,
              "product_id": productId,
              "qty": quantity
          ]
          
          do {
              if let responseData = try await WebService().postData(url: "https://dec2one.firesvlk.online:8443/api/v1/cart", token: token, body: body) {
                  if let responseDictionary = responseData as? [String: Any] {
                    
                          // Show success message to user
                          print("Product added to cart successfully.")
                          
                          return true
               
                  } else {
                      print("Error: Unexpected response format")
                  }
              }
          } catch {
              if let errorDescription = error.localizedDescription as? String, errorDescription.contains("401") {
                  // Trigger auto-login process
                  print("unauthorized")
              } else {
                  print("Error: \(error)")
              }
          }
        return false
      }
    
    
    

    
    
    func getCartDetails33(for userId: String) async -> [CartItem] {
        guard let token = LoginViewModel().getTokenFromKeychain() else {
            print("Token not found")
            return []
        }

        let url = "https://dec2one.firesvlk.online:8443/api/v1/cart/\(userId)"
        print(url)
        do {
            if let responseData = try await WebService().getCartDetails(fromURL: url, token: token) {
            
                    print("Cart details: \(responseData)")
                return responseData
                
            }
        } catch {
            if let errorDescription = error.localizedDescription as? String, errorDescription.contains("401") {
                // Trigger auto-login process
                print("Unauthorized")
            } else {
                print("Error: \(error)")
            }
        }
        return []
    }
}
