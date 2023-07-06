//
//  UserProfileRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol ProfileRouterProtocol {
    func toLogin()
    func toAddresses()
    func toPaymentInfo()
}

final class ProfileRouter {
    
    private weak var view: UIViewController?
    private let windowManager: RootWindowManagerProtocol?
    
    init(view: UIViewController, windowManager: RootWindowManagerProtocol) {
        self.view = view
        self.windowManager = windowManager
    }
    
    static func startProfileModule() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter(view: view, windowManager: RootWindowManager.shared)
        let interactor = ProfileInteractor(userInfoManager: UserInfoManager.shared, authManager: AuthManager.shared)
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension ProfileRouter: ProfileRouterProtocol {
    func toLogin() {
        let loginModule = UINavigationController(rootViewController: LoginRouter.startLogin())
        windowManager?.changeRootViewController(loginModule)
    }
    
    func toAddresses() {
        let addressesModule = AddressesRouter.startAddressesModule()
        self.view?.navigationController?.pushViewController(addressesModule, animated: true)
    }
    
    func toPaymentInfo() {
        let paymentInfoModule = PaymentInfoRouter.startPaymentInfoModule()
        self.view?.navigationController?.pushViewController(paymentInfoModule, animated: true)
    }
}
