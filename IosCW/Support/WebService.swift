//
//  WebService.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-27.
//

import Foundation

class WebService {
    func getData(fromURL urlString: String, token: String) async throws -> [Product]? {
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return nil
           }

           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           
           // Set authorization header with JWT token
           request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

           do {
               let (data, _) = try await URLSession.shared.data(for: request)
               let decoder = JSONDecoder()
               let products = try decoder.decode([Product].self, from: data)
               return products
           } catch {
               print("Error downloading data: \(error)")
               return nil
           }
       }
    
    func postData(url urlString: String, token: String, body: [String: Any]) async throws -> [String: Any]? {
          guard let url = URL(string: urlString) else {
              print("Invalid URL")
              return nil
          }

          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          
          // Set authorization header with JWT token
          request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
          
          // Set the content type to JSON
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")

          do {
              let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
              request.httpBody = jsonData
              
              let (data, _) = try await URLSession.shared.data(for: request)
              let responseObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
              return responseObject
          } catch {
              print("Error performing POST request: \(error)")
              return nil
          }
      }
    
    func getCartDetails(fromURL urlString: String, token: String) async throws -> [CartItem]? {
//            let urlString = "https://dec2one.firesvlk.online:8443/api/v1/cart/\(userId)"

            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return nil
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            // Set authorization header with JWT token
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
                   let (data, _) = try await URLSession.shared.data(for: request)
                   let decoder = JSONDecoder()

                   // Try decoding as dictionary
                   if let dictionaryResponse = try? decoder.decode([String: CartItem].self, from: data) {
                       // Extract values from dictionary
                       let cartItems = Array(dictionaryResponse.values)
                       return cartItems
                   }

                   // Try decoding as array
                   if let arrayResponse = try? decoder.decode([CartItem].self, from: data) {
                       return arrayResponse
                   }

                   // If unable to decode as dictionary or array, return nil
                   print("Error: Unable to decode response as dictionary or array")
                   return nil
               } catch {
                   print("Error fetching cart details: \(error)")
                   return nil
               }
        }
}
