//
//  ProductDetailInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation

protocol ProductDetailInteractorInputs {
    func getProduct()
    func favButtonTapped(model: ProductModel?)
    func isFav(model: ProductModel?) -> Bool
    func addProductToBasket(product: ProductModel?)
    func getBasketItems()
}

protocol ProductDetailInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(errorMessage: String)
    func showModel(model: ProductModel?)
    func addToBasketSucceed()
}

final class ProductDetailInteractor {
    weak var presenter: ProductDetailInteractorOutputs?
    private let service: ProductsServiceProtocol?
    private let storageManager: RealmManagerProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    private let basketManager: BasketManagerProtocol?
    
    private var productID: Int
    
    private var basketItems: [BasketModel] = []
    
    init(productID: Int,
         service: ProductsServiceProtocol,
         storageManager: RealmManagerProtocol,
         userInfoManager: UserInfoManagerProtocol,
         basketManager: BasketManagerProtocol)
    {
        self.productID = productID
        self.service = service
        self.storageManager = storageManager
        self.userInfoManager = userInfoManager
        self.basketManager = basketManager
    }
}

extension ProductDetailInteractor: ProductDetailInteractorInputs {
    
    func getProduct() {
        Task {
            presenter?.startLoading()
            
            try await service?.fetchProduct(id: self.productID) { [weak self] result in
                guard let self else { return }
                presenter?.endLoading()
                
                switch result {
                case .success(let model):
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.showModel(model: model)
                    }
                case .failure(let error):
                    presenter?.onError(errorMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func isFav(model: ProductModel?) -> Bool {
        let favs = storageManager?.getAll(FavoriteProductModel.self).filter { $0.userId == userInfoManager?.getUserUid() }
        return favs?.filter { $0.productTitle == model?.title }.isEmpty == true ? false : true
    }
    
    func favButtonTapped(model: ProductModel?) {
        guard let model else { return }
        let favModel = FavoriteProductModel(userId: userInfoManager?.getUserUid(),
                                            productId: model.id,
                                            productImage: model.image,
                                            productTitle: model.title)
        
        if !isFav(model: model) {
            storageManager?.create(favModel) { [weak self] error in
                guard let self else { return }
                self.presenter?.onError(errorMessage: error.localizedDescription)
            }
        } else {
            let favs = storageManager?.getAll(FavoriteProductModel.self).filter { $0.userId == userInfoManager?.getUserUid() }
            if let index = favs?.firstIndex(where: { $0.productId == favModel.productId }) {
                if let item = favs?[index] {
                    storageManager?.delete(item, onError: { [weak self] error in
                        guard let self else { return }
                        self.presenter?.onError(errorMessage: error.localizedDescription)
                    })
                }
            }
        }
    }
    
    func getBasketItems() {
        basketManager?.getBasketItems { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let items):
                self.basketItems = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addProductToBasket(product: ProductModel?) {
        self.presenter?.startLoading()
        
        if let product {
            var data: [String: Any] = [:]
            data["userId"] = userInfoManager?.getUserUid()
            data["uuid"] = UUID().uuidString
            data["productId"] = product.id
            data["productTitle"] = product.title
            data["productPrice"] = product.price
            data["imageURL"] = product.image
            data["count"] = 1
            
            if basketItems.contains(where: { $0.productId == product.id }) == true {
                presenter?.onError(errorMessage: "The product is already added.")
                presenter?.endLoading()
            } else {
                basketManager?.addBasket(data: data, completion: { [weak self] results in
                    guard let self else { return }
                    self.presenter?.endLoading()
                    switch results {
                    case .success(_):
                        self.presenter?.addToBasketSucceed()
                    case .failure(let error):
                        self.presenter?.onError(errorMessage: error.localizedDescription)
                    }
                })
            }
        }
    }
}
