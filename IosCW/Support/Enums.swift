//
//  Enums.swift
//  IosCW
//
//  Created by Naveen Dhananjaya on 2024-03-20.
//

import Foundation
enum Categories : String {
     case All = "All"
     case Apperel = "Apperel"
     case Dress = "Dress"
     case TShirt = "T-Shirt"
     case Bag = "Bag"
}

enum Gender : String {
     case UniSex = "All"
     case Male = "Men"
     case Female = "Women"
   
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
