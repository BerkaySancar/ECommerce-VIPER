//
//  ProductDetailInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation

protocol ProductDetailInteractorInputs {
    func getProduct()
}

protocol ProductDetailInteractorOutputs: AnyObject {
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(error: NetworkError)
    func showModel(model: ProductModel?)
}

final class ProductDetailInteractor {
    weak var presenter: ProductDetailInteractorOutputs?
    private let service: ProductsServiceProtocol?
    
    private var productID: Int
    
    init(productID: Int, service: ProductsServiceProtocol) {
        self.productID = productID
        self.service = service
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
                    presenter?.onError(error: error)
                }
            }
        }
    }
}
