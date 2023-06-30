//
//  FavoritesRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol FavoritesRouterProtocol {
    
}

final class FavoritesRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startFavoritesModule() -> UIViewController {
        let view = FavoritesViewController()
        let router = FavoritesRouter(view: view)
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    
}
