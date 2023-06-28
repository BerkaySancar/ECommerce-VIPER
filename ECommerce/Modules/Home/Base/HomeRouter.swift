//
//  HomeRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol HomeRouterProtocol {
    
}

final class HomeRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startHomeModule() -> UIViewController {
        let view = HomeViewController()
        let router = HomeRouter(view: view)
        let interactor = HomeInteractor(service: ProductsService.shared)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    
}
