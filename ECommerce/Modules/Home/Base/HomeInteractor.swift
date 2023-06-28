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
}

protocol HomeInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(error: NetworkError)
}

final class HomeInteractor {
    weak var presenter: HomeInteractorOutputs?
    private let service: ProductsServiceProtocol?
    
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
    
    init(service: ProductsServiceProtocol) {
        self.service = service
    }
}

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
    
}
