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
}

protocol HomeInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(error: NetworkError)
    func showProfileImageAndEmail(model: NavBarViewModel)
}

final class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let service: ProductsServiceProtocol?
    private let manager: UserInfoManagerProtocol?
    
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
    
    init(service: ProductsServiceProtocol, manager: UserInfoManagerProtocol) {
        self.service = service
        self.manager = manager
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
                    presenter?.onError(error: error)
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
        manager?.getUserProfilePictureAndEmail { [weak self] imageURLString, email in
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
                        DispatchQueue.main.async {
                            self.products = products
                        }
                    case .failure(let error):
                        self.presenter?.onError(error: error)
                    }
                }
            }
        }
    }
}
