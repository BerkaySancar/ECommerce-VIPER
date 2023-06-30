//
//  FavoriteProductModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation
import RealmSwift

class FavoriteProductModel: Object {
    @Persisted var productId: Int
    @Persisted var productImage: String
    @Persisted var productTitle: String
    
    convenience init(productId: Int, productImage: String, productTitle: String) {
        self.init()
        self.productId = productId
        self.productImage = productImage
        self.productTitle = productTitle
    }
}
