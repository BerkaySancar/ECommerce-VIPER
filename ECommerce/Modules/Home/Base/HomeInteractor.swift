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
}

protocol HomeInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(error: NetworkError)
    func showProfileImage(imageURLString: String?, email: String?)
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
                        self.categories = data.categories
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
            self.presenter?.showProfileImage(imageURLString: imageURLString, email: email)
        }
    }
    
    func searchTextDidChange(text: String) {
        if text.count == 0 {
           getData()
        } else if text.count > 1 {
            self.products = products.filter { $0.title.lowercased().contains(text.lowercased()) }
        }
    }
}
