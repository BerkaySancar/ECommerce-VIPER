//
//  CompleteOrderInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation
import FirebaseFirestore.FIRFieldValue

protocol CompleteOrderInteractorInputs {
    func getAddresses()
    func getCards()
    func showAddresses() -> [AddressModel]?
    func showCards() -> [CardModel]?
    func showTotalAndDeliveryPrice() -> (price: Double, delivery: Double)?
    func saveOrder(address: AddressModel?, card: CardModel?)
}

protocol CompleteOrderInteractorOutputs: AnyObject {
    func dataRefreshed()
    func alert(title: String, message: String)
    func orderSuccess()
}

final class CompleteOrderInteractor {
    weak var presenter: CompleteOrderInteractorOutputs?
    private let storageManager: RealmManagerProtocol?
    private let basketManager: BasketManagerProtocol?
    
    let firestore = Firestore.firestore()

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
    
    init(items: [BasketModel]?, storageManager: RealmManagerProtocol, basketManager: BasketManagerProtocol) {
        self.storageManager = storageManager
        self.basketManager = basketManager
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
    
    func saveOrder(address: AddressModel?, card: CardModel?) {
        if let address = address, let card = card {
            let userId = address.userId
            let userNameSurname = card.nameSurname
            let street = address.street
            let buildingNumber = address.buildingNumber
            let city = address.city
            let country = address.country
            let cardNo = card.cardNumber
            let date = FieldValue.serverTimestamp()
            
            //MARK: SAVE ADRESS
            let addressData: [String: Any] = [
                "street": street,
                "buildingNumber": buildingNumber,
                "city": city,
                "country": country
            ]
            let addressRef = firestore.collection("Addresses").document()
            addressRef.setData(addressData)
            
            //MARK: SAVE CARD
            let cardData: [String: Any] = [
                "cardNumber": cardNo
            ]
            let cardRef = firestore.collection("Cards").document()
            cardRef.setData(cardData)
            
            //MARK: SAVE ORDER
            var products: [String: Int] = [:]
            var total = 5.50
            if let items {
                for item in items {
                    products[item.productTitle] = item.count
                    total += item.productPrice * Double(item.count)
                }
            }
            let data: [String: Any] = [
                "customerName": userNameSurname,
                "userId": userId ?? "",
                "address": addressRef,
                "card": cardRef,
                "products": products,
                "total": total,
                "date": date
            ]
            
            firestore.collection("Orders").addDocument(data: data) { [weak self] error in
                guard let self else { return }
                if error != nil {
                    self.presenter?.alert(title: "", message: FirebaseError.addOrderFailed.localizedDescription)
                } else {
                    if let basketItems = self.items {
                        for item in basketItems {
                            basketManager?.deleteBasketItem(item: item, completion: { error in
                                print(error.localizedDescription)
                            })
                        }
                    }
                    self.presenter?.alert(title: "Success", message: "The order has been created. It will be delivered as soon as possible.Thank you.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                        self?.presenter?.orderSuccess()
                    }
                }
            }
        }
    }
}
