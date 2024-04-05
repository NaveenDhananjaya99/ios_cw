//
//  LoginModelView.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-28.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    struct LoginResponse: Decodable {
        let refreshToken: String
        let id: Int
        let username: String
        let email: String
        let roles: [String]
        let accessToken: String
        let tokenType: String
    }
    func loginUser(userName: String, password: String) {
        guard let url = URL(string: "https://dec2one.firesvlk.online:8443/api/auth/signin") else {
            print("Invalid URL")
            return
        }

        let parameters = ["username": userName, "password": password]

        guard let postData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error encoding parameters")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData

        URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                       DispatchQueue.main.async {
                           self.errorMessage = error?.localizedDescription ?? "Unknown error"
                       }
                       return
                   }

                   do {
                       let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                       DispatchQueue.main.async {
                           // Save the token securely to Keychain
                           self.saveTokenToKeychain(token: decodedResponse.accessToken)
                           UserDefaults.standard.set(userName, forKey: "savedUserName")
                           UserDefaults.standard.set(password, forKey: "savedPassword")
                           self.isLoggedIn = true
                           print("Response:", decodedResponse)
                           // You can do further actions here upon successful login
                       }
                   } catch {
                       DispatchQueue.main.async {
                           self.errorMessage = "Error decoding response: \(error.localizedDescription)"
                       }
                   }
               }.resume()
           }

           private func saveTokenToKeychain(token: String) {
               let keychainItem = [
                   kSecClass as String: kSecClassGenericPassword as String,
                   kSecAttrAccount as String: "accessToken",
                   kSecValueData as String: token.data(using: .utf8)!
               ] as CFDictionary

               // Delete existing token before saving the new one
               SecItemDelete(keychainItem)

               // Add new token to Keychain
               let status = SecItemAdd(keychainItem, nil)
               if status != errSecSuccess {
                   print("Error saving token to Keychain")
               }
           }

           func getTokenFromKeychain() -> String? {
               let query = [
                   kSecClass as String: kSecClassGenericPassword,
                   kSecAttrAccount as String: "accessToken",
                   kSecReturnData as String: kCFBooleanTrue!,
                   kSecMatchLimit as String: kSecMatchLimitOne
               ] as CFDictionary

               var result: AnyObject?
               let status = SecItemCopyMatching(query, &result)

               if status == errSecSuccess, let data = result as? Data {
                   return String(data: data, encoding: .utf8)
               } else {
                   print("Error retrieving token from Keychain")
                   return nil
               }
           }
       }
