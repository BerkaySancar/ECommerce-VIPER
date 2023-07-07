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
    func updateItem(value: Double, item: BasketModel?)
    func deleteItem(item: BasketModel?)
    func calculateTotal() -> Double
}

protocol BasketInteractorOutputs: AnyObject {
    func onError(message: String)
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func showTotal(price: Double)
}

final class BasketInteractor {
    weak var presenter: BasketInteractorOutputs?
    private let basketManager: BasketManagerProtocol?
    
    private var basketItems: [BasketModel]? {
        didSet {
            presenter?.showTotal(price: self.calculateTotal())
        }
    }
    
    init(basketManager: BasketManagerProtocol) {
        self.basketManager = basketManager
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
                    guard let self else { return }
                    self.basketItems = items
                    self.presenter?.dataRefreshed()
                    self.presenter?.showTotal(price: self.calculateTotal())
                }
            case .failure(let error):
                self.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func showItems() -> [BasketModel]? {
        return self.basketItems
    }
    
    func deleteItem(item: BasketModel?) {
        basketManager?.deleteBasketItem(item: item) { [weak self] error in
            guard let self else { return }
            presenter?.onError(message: error.localizedDescription)
        }
    }
   
    func updateItem(value: Double, item: BasketModel?) {
        if let index = basketItems?.firstIndex(where: { $0.uuid == item?.uuid }) {
            if let item = basketItems?[index] {
                if value == 0 {
                    deleteItem(item: item)
                } else {
                    item.count = Int(value)
                    basketManager?.update(item: item)
                }
            }
        }
    }
    
    func calculateTotal() -> Double {
        var total = 0.0
        
        if let items = basketItems {
            for item in items {
                total += item.productPrice * Double(item.count)
            }
        }
        return total
    }
}
