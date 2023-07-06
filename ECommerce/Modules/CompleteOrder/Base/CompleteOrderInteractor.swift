//
//  CompleteOrderInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation

protocol CompleteOrderInteractorInputs {
    func getAddresses()
    func getCards()
    func showAddresses() -> [AddressModel]?
    func showCards() -> [CardModel]?
    func showTotalAndDeliveryPrice() -> (price: Double, delivery: Double)?
}

protocol CompleteOrderInteractorOutputs: AnyObject {
    func dataRefreshed()
}

final class CompleteOrderInteractor {
    weak var presenter: CompleteOrderInteractorOutputs?
    private let storageManager: RealmManagerProtocol?

    private var addresses: [AddressModel]? {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    private var cards: [CardModel]? {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    private var items: [BasketModel]?
    
    init(items: [BasketModel]?, storageManager: RealmManagerProtocol) {
        self.storageManager = storageManager
        self.items = items
    }
}

extension CompleteOrderInteractor: CompleteOrderInteractorInputs {
    
    func getAddresses() {
        self.addresses = storageManager?.getAll(AddressModel.self)
    }
    
    func getCards() {
        self.cards = storageManager?.getAll(CardModel.self)
    }
    
    func showAddresses() -> [AddressModel]? {
        return self.addresses
    }
    
    func showCards() -> [CardModel]? {
        return self.cards
    }
    
    func showTotalAndDeliveryPrice() -> (price: Double, delivery: Double)? {
        var total = 0.0
        let deliveryPrice = 5.50
        
        if let items {
            for item in items {
                total += item.productPrice * Double(item.count)
            }
        }
        return (total, deliveryPrice)
    }
}
