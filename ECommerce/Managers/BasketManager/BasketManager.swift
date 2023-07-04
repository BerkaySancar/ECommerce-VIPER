//
//  BasketManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 4.07.2023.
//

import Foundation
import FirebaseFirestore

protocol BasketManagerProtocol {
    func addBasket(data: [String: Any], completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func getBasketItems(completion: @escaping (Result<[BasketModel], FirebaseError>) -> Void)
}

final class BasketManager {
    
    static let shared = BasketManager()
    
    private let firestore = Firestore.firestore()
    
    private var basketItems: [BasketModel] = []
    
    private init() {}
}

extension BasketManager: BasketManagerProtocol {
    
    func addBasket(data: [String: Any], completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        firestore.collection("Basket").addDocument(data: data) { error in
            if let error {
                completion(.failure(.addProductToBasket))
                print(error.localizedDescription)
            } else {
                completion(.success(()))
            }
        }
    }
    
    func getBasketItems(completion: @escaping (Result<[BasketModel], FirebaseError>) -> Void) {
        if let userId = UserInfoManager.shared.getUserUid() {
            firestore.collection("Basket").whereField("userId", isEqualTo: userId).addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                
                if let error {
                    completion(.failure(.getBasketItemsFailed))
                    print(error)
                } else {
                    guard let documents = snapshot?.documents else { return }
                    self.basketItems.removeAll()
                    for document in documents {
                        if let userId = document.get("userId") as? String,
                           let productTitle = document.get("productTitle") as? String,
                           let productPrice = document.get("productPrice") as? Double,
                           let imageURL = document.get("imageURL") as? String
                        {
                            let basketItem: BasketModel = .init(userId: userId, productTitle: productTitle, productPrice: productPrice, imageURL: imageURL)
                            self.basketItems.append(basketItem)
                        }
                    }
                    completion(.success(self.basketItems))
                }
            }
        }
    }
}
