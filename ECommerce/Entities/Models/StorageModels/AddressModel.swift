//
//  AddressModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation
import RealmSwift

class AddressModel: Object {
    @Persisted var userId: String?
    @Persisted var uuid: UUID?
    @Persisted var name: String
    @Persisted var country: String
    @Persisted var city: String
    @Persisted var street: String
    @Persisted var buildingNumber: Int
    @Persisted var zipCode: Int
    
    convenience init(userId: String?, uuid: UUID?, name: String, country: String, city: String, street: String, buildingNumber: Int, zipCode: Int) {
        self.init()
        self.userId = userId
        self.uuid = uuid
        self.name = name
        self.country = country
        self.city = city
        self.street = street
        self.buildingNumber = buildingNumber
        self.zipCode = zipCode
    }
}
