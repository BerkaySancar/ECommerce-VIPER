//
//  MainTabBarPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol MainTabBarPresenterInputs {
    func viewWillAppear()
}

final class MainTabBarPresenter {
    private weak var view: MainTabBarViewProtocol?
    private let interactor: MainTabBarInteractorInputs?
    private let router: MainTabBarRouterProtocol?
    
    init(view: MainTabBarViewProtocol, interactor: MainTabBarInteractorInputs, router: MainTabBarRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension MainTabBarPresenter: MainTabBarPresenterInputs {
    
    func viewWillAppear() {
        view?.configureTabBar()
        view?.setTabBarControllers()
        interactor?.getBasketItems()
    }
}

extension MainTabBarPresenter: MainTabBarInteractorOutputs {
  
    func showBasketItemsCount(value: Int) {
        view?.setBasketItemsBadgeValue(value: value)
    }
}


