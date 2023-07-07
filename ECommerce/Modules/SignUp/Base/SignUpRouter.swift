//
//  SignUpRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation
import UIKit.UIViewController

protocol SignUpRouterProtocol {
    func toLogin()
}

final class SignUpRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startSignUp() -> UIViewController {
        let view = SignUpViewController(nibName: "SignUpView", bundle: nil)
        let router = SignUpRouter(view: view)
        let interactor = SignUpInteractor(authManager: AuthManager.shared)
        let presenter = SignUpPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func toLogin() {
        view?.navigationController?.popViewController(animated: true)
    }
}
