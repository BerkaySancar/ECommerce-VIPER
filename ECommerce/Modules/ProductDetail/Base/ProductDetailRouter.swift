//
//  ProductDetailRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProductDetailRouterProtocol {
    func toHome()
    func toBasket()
}

final class ProductDetailRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startModule(productID: Int) -> UIViewController {
        let view = ProductDetailViewController()
        let router = ProductDetailRouter(view: view)
        let interactor = ProductDetailInteractor(productID: productID,
                                                 service: ProductsService.shared,
                                                 storageManager: RealmManager.shared,
                                                 userInfoManager: UserInfoManager.shared,
                                                 basketManager: BasketManager.shared)
        let presenter = ProductDetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProductDetailRouter: ProductDetailRouterProtocol {
    func toHome() {
        self.view?.navigationController?.popViewController(animated: true)
    }
    
    func toBasket() {
        toHome()
        self.view?.tabBarController?.selectedIndex = 2
    }
}
