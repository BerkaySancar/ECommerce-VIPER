//
//  LoginRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol LoginRouterProtocol {
    
}

final class LoginRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startLogin() -> UIViewController {
        let view = LoginViewController(nibName: "LoginView", bundle: nil)
        let router = LoginRouter(view: view)
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension LoginRouter: LoginRouterProtocol {
    
}
