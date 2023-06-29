//
//  ProductsModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Float
    let description: String
    let category: String
    let image: String
    let rating: Rate
}

struct Rate: Codable {
    let rate: Float
    let count: Int
}
