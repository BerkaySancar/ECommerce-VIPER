//
//  LoginPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol LoginPresenterInputs {
    
}

final class LoginPresenter {
    private weak var view: LoginViewProtocol?
    private let interactor: LoginInteractorInputs?
    private let router: LoginRouterProtocol?
    
    init(view: LoginViewProtocol, interactor: LoginInteractorInputs, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension LoginPresenter: LoginPresenterInputs {
    
}

extension LoginPresenter: LoginInteractorOutputs {
    
}
