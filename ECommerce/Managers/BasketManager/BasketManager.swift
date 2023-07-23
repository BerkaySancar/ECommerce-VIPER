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
    func deleteBasketItem(item: BasketModel?, completion: @escaping (FirebaseError) -> Void)
    func update(item: BasketModel?)
}

final class BasketManager {
    
    private let firestore = Firestore.firestore()
    private let userInfoManager = UserInfoManager()
    private var basketItems: [BasketModel] = []
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
        if let userId = userInfoManager.getUserUid() {
            firestore.collection("Basket").whereField("userId", isEqualTo: userId).addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                
                if let error {
                    print("items can not fetched: \(error.localizedDescription)")
                    completion(.failure(.getBasketItemsFailed))
                    return
                } else {
                    guard let documents = snapshot?.documents else { return }
                    self.basketItems.removeAll()
                    for document in documents {
                        if let userId = document.get("userId") as? String,
                           let uuid = document.get("uuid") as? String,
                           let productId = document.get("productId") as? Int,
                           let productTitle = document.get("productTitle") as? String,
                           let productPrice = document.get("productPrice") as? Double,
                           let imageURL = document.get("imageURL") as? String,
                           let count = document.get("count") as? Int
                        {
                            let basketItem: BasketModel = .init(userId: userId, uuid: uuid, productId: productId, productTitle: productTitle, productPrice: productPrice, imageURL: imageURL, count: count)
                            self.basketItems.append(basketItem)
                        }
                    }
                    completion(.success(self.basketItems))
                }
            }
        }
    }
    
    func update(item: BasketModel?) {
        if let userId = userInfoManager.getUserUid() {
            
            firestore.collection("Basket").whereField("userId", isEqualTo: userId).getDocuments { [weak self] snapshot, error in
                guard let self else { return }
                if let error {
                    print(error.localizedDescription)
                    return
                } else {
                    for document in snapshot!.documents {
                        if document.get("uuid") as? String == item?.uuid {
                            let data: [String: Any] = ["count": item?.count ?? 0,
                                                       "productPrice": item?.productPrice ?? 0]
                            self.firestore.collection("Basket").document(document.documentID).updateData(data)
                            break
                        }
                    }
                }
            }
        }
    }
    
    func deleteBasketItem(item: BasketModel?, completion: @escaping (FirebaseError) -> Void) {
        if let userId = userInfoManager.getUserUid() {
            firestore.collection("Basket").whereField("userId", isEqualTo: userId).addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                if let error {
                    print("items can not fetched: \(error.localizedDescription)")
                    return
                } else {
                    guard let documents = snapshot?.documents else { return }
                    for document in documents {
                        let data = document.data()
                        if data["uuid"] as? String == item?.uuid {
                            self.firestore.collection("Basket").document(document.documentID).delete() { err in
                                if let err {
                                    print("Error removing document: \(err)")
                                    completion((.itemCouldNotBeRemoved))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
