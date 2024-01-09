//
//  HomeInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

protocol HomeInteractorInputs {
    func getData()
    func showProducts() -> [ProductModel]
    func showCategories() -> Categories
    func getUserProfilePictureAndEmail()
    func searchTextDidChange(text: String)
    func getCategoryProducts(category: String)
    func getFavorites()
    func favAction(model: ProductModel?)
    func isFav(model: ProductModel?) -> Bool 
}

protocol HomeInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(errorMessage: String)
    func showProfileImageAndEmail(model: CurrentUserModel)
}

final class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let service: ProductsServiceProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    private let storageManager: RealmManagerProtocol?
    
    private var products: [ProductModel] = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    private var categories: Categories = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    private var favs: [FavoriteProductModel]? {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    init(service: ProductsServiceProtocol, manager: UserInfoManagerProtocol, storageManager: RealmManagerProtocol) {
        self.service = service
        self.userInfoManager = manager
        self.storageManager = storageManager
    }
}

// MARK: - Home Interactor Inputs
extension HomeInteractor: HomeInteractorInputs {
    
    func getData() {
        Task {
            presenter?.startLoading()
            
            try await service?.fetchProductsAndCategories { [weak self] result in
                guard let self else { return }
                self.presenter?.endLoading()
                
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.products = data.products
                        self.categories.append("All Products")
                        self.categories.append(contentsOf: data.categories)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.presenter?.onError(errorMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func showProducts() -> [ProductModel] {
        return self.products
    }
    
    func showCategories() -> Categories {
        return self.categories
    }
    
    func getUserProfilePictureAndEmail() {
        userInfoManager?.getUserProfilePictureAndEmail { [weak self] imageURLString, email in
            guard let self else { return }
            self.presenter?.showProfileImageAndEmail(model: .init(profileImageURLString: imageURLString, userEmail: email))
        }
    }
    
    func searchTextDidChange(text: String) {
        if text.count == 0 {
            self.categories = []
            getData()
        } else if text.count > 1 {
            self.products = products.filter { $0.title.lowercased().contains(text.lowercased()) }
        }
    }
    
    func getCategoryProducts(category: String) {
        if category.contains("All Products") {
            self.categories = []
            getData()
        } else {
            Task {
                presenter?.startLoading()
                
                try await service?.fetchCategoryProducts(category: category.lowercased()) { [weak self] result in
                    guard let self else { return }
                    self.presenter?.endLoading()
                    
                    switch result {
                    case .success(let products):
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            self.products = products
                        }
                    case .failure(let error):
                        self.presenter?.onError(errorMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getFavorites() {
        self.favs = storageManager?.getAll(FavoriteProductModel.self).filter { $0.userId == userInfoManager?.getUserUid() }
    }
    
    func isFav(model: ProductModel?) -> Bool {
        return self.favs?.filter { $0.productId == model?.id }.isEmpty == true ? false : true
    }
    
    func favAction(model: ProductModel?) {
        guard
            let model,
            let favs
        else { return }
        
        if let index = self.favs?.firstIndex(where: { $0.productId == model.id }) {
            storageManager?.delete(favs[index]) { [weak self] error in
                guard let self else { return }
                presenter?.onError(errorMessage: error.localizedDescription)
            }
            self.favs?.remove(at: index)
        } else {
            let favModel = FavoriteProductModel(userId: userInfoManager?.getUserUid(),
                                                productId: model.id,
                                                productImage: model.image,
                                                productTitle: model.title)
            
            storageManager?.create(favModel) { [weak self] error in
                guard let self else { return }
                self.presenter?.onError(errorMessage: error.localizedDescription)
            }
            getFavorites()
        }
    }
}
