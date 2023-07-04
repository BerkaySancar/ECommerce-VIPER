//
//  BasketInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import Foundation

protocol BasketInteractorInputs {
    func getItems()
    func showItems() -> [BasketModel]?
}

protocol BasketInteractorOutputs: AnyObject {
    func onError(message: String)
    func startLoading()
    func endLoading()
    func dataRefreshed()
}

final class BasketInteractor {
    weak var presenter: BasketInteractorOutputs?
    private let basketManager: BasketManagerProtocol?
    
    private var basketItems: [BasketModel]?
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
        basketItems = []
    }
}

extension BasketInteractor: BasketInteractorInputs {
    
    func getItems() {
        presenter?.startLoading()
        basketManager?.getBasketItems { [weak self] result in
            guard let self else { return }
            self.presenter?.endLoading()
            
            switch result {
            case .success(let items):
                DispatchQueue.main.async { [weak self] in
                    self?.basketItems = items
                    self?.presenter?.dataRefreshed()
                }
            case .failure(let error):
                self.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func showItems() -> [BasketModel]? {
        return self.basketItems
    }
}
