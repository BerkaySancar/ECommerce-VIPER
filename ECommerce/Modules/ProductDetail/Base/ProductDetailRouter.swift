//
//  ProductDetailRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProductDetailRouterProtocol {
    
}

final class ProductDetailRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startModule(productID: Int) -> UIViewController {
        let view = ProductDetailViewController()
        let router = ProductDetailRouter(view: view)
        let interactor = ProductDetailInteractor(productID: productID, service: ProductsService.shared)
        let presenter = ProductDetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterProtocol {
    
}
