//
//  CardModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation
import RealmSwift

class CardModel: Object {
    @Persisted var userId: String
    @Persisted var uuid: String
    @Persisted var nameSurname: String
    @Persisted var cardName: String
    @Persisted var cardNumber: String
    @Persisted var month: String
    @Persisted var year: String
    @Persisted var cvv: String
    
    convenience init(userId: String,
                     uuid: String,
                     nameSurname: String,
                     cardName: String,
                     cardNumber: String,
                     month: String,
                     year: String,
                     cvv: String)
    {
        self.init()
        self.userId = userId
        self.cardName = cardName
        self.nameSurname = nameSurname
        self.cvv = cvv
        self.month = month
        self.year = year
        self.uuid = uuid
        self.cardNumber = cardNumber
    }
}
