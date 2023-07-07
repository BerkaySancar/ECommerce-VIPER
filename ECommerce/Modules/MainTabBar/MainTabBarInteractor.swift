//
//  MainTabBarInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol MainTabBarInteractorInputs {
    func getBasketItems()
}

protocol MainTabBarInteractorOutputs: AnyObject {
    func showBasketItemsCount(value: Int)
}

final class MainTabBarInteractor {
    weak var presenter: MainTabBarInteractorOutputs?
    
    private var basketItems: [BasketModel] = [] {
        didSet {
            presenter?.showBasketItemsCount(value: basketItems.count)
        }
    }
}

extension MainTabBarInteractor: MainTabBarInteractorInputs {
  
    func getBasketItems() {
        BasketManager.shared.getBasketItems { result in
            switch result {
            case .success(let success):
                self.basketItems = success
            case .failure(_):
                break
            }
        }
    }
}
