//
//  BasketRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol BasketRouterProtocol {
    func toHome()
}

final class BasketRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startBasketModule() -> UIViewController {
        let view = BasketViewController()
        let router = BasketRouter(view: view)
        let interactor = BasketInteractor(basketManager: BasketManager.shared)
        let presenter = BasketPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension BasketRouter: BasketRouterProtocol {
    
    func toHome() {
        self.view?.tabBarController?.selectedIndex = 0
    }
}
