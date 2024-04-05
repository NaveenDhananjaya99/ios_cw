//
//  ProductModel.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-21.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let name : String
    let price : Double
    let description : String
    let productImages : [ProductImage]
//    let category : Categories
//    let gender : Gender
    
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        id = try container.decode(Int.self, forKey: .id)
//        titel = try container.decode(String.self, forKey: .titel)
//        price = try container.decode(Double.self, forKey: .price)
//        description = try container.decode(String.self, forKey: .description)
//        images = try container.decode([String].self, forKey: .images)
//      
//    }
    
}
