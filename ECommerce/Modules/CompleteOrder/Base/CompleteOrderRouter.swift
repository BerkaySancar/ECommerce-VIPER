//
//  CompleteOrderRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol CompleteOrderRouterProtocol {
    func toPaymentInfo()
    func toAddresses()
    func toHome()
}

final class CompleteOrderRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startCompleteOrderModule(items: [BasketModel]?) -> UIViewController {
        let view = CompleteOrderViewController()
        let router = CompleteOrderRouter(view: view)
        let interactor = CompleteOrderInteractor(items: items, storageManager: RealmManager.shared, basketManager: BasketManager.shared)
        let presenter = CompleteOrderPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension CompleteOrderRouter: CompleteOrderRouterProtocol {
    
    func toPaymentInfo() {
        let paymentInfoModule = PaymentInfoRouter.startPaymentInfoModule()
        self.view?.navigationController?.pushViewController(paymentInfoModule, animated: true)
    }
    
    func toAddresses() {
        let addressesModule = AddressesRouter.startAddressesModule()
        self.view?.navigationController?.pushViewController(addressesModule, animated: true)
    }
    
    func toHome() {
        let tabBar = MainTabBarRouter.startTabBarModule()
        RootWindowManager.shared.changeRootViewController(tabBar)
    }
}
