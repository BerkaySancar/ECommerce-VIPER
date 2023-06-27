//
//  LoginInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol LoginInteractorInputs {
    func loginTapped(email: String, password: String)
}

protocol LoginInteractorOutputs: AnyObject {
    func loginFailed(error: FirebaseError)
    func loginSucceed()
}

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension LoginInteractor: LoginInteractorInputs {
    
    func loginTapped(email: String, password: String) {
        authManager?.login(email: email, password: password) { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.loginSucceed()
            case .failure(let error):
                presenter?.loginFailed(error: error)
            }
        }
    }
}
