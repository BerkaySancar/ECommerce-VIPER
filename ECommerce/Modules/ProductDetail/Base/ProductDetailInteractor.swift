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
}

protocol ProductDetailInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(errorMessage: String)
    func showModel(model: ProductModel?)
}

final class ProductDetailInteractor {
    weak var presenter: ProductDetailInteractorOutputs?
    private let service: ProductsServiceProtocol?
    private let storageManager: RealmManagerProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    
    private var productID: Int
    
    init(productID: Int, service: ProductsServiceProtocol, storageManager: RealmManagerProtocol, userInfoManager: UserInfoManagerProtocol) {
        self.productID = productID
        self.service = service
        self.storageManager = storageManager
        self.userInfoManager = userInfoManager
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
        return storageManager?.getAll(FavoriteProductModel.self).filter { $0.productTitle == model?.title }.isEmpty == true ? false : true
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
}
