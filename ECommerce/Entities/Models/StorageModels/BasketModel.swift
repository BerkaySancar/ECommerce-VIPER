//
//  BasketModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 4.07.2023.
//

import Foundation

class BasketModel {

    let userId: String
    let uuid: String
    let productId: Int
    let productTitle: String
    var productPrice: Double
    let imageURL: String
    var count: Int
    
    init(userId: String, uuid: String, productId: Int, productTitle: String, productPrice: Double, imageURL: String, count: Int) {
        self.userId = userId
        self.uuid = uuid
        self.productId = productId
        self.productTitle = productTitle
        self.productPrice = productPrice
        self.imageURL = imageURL
        self.count = count
    }
}
