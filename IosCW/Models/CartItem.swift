//
//  CartItem.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-24.
//

import Foundation


class CartItem : Codable {
    var product : Product
    var qty : Int = 0
    let user_id: Int
    let product_id: Int
    let id: Int
    
    init(product: Product, quantity: Int, userId: Int, productId: Int, id: Int) {
          self.product = product
          self.qty = quantity
          self.user_id = userId
          self.product_id = productId
          self.id = id
      }
    
  
}


