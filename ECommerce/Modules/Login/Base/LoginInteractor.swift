//
//  LoginInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol LoginInteractorInputs {
    func login(email: String, password: String)
    func forgotPassword(email: String)
    func googleSignIn()
}

protocol LoginInteractorOutputs: AnyObject {
    func loginFailed(error: FirebaseError)
    func loginSucceed()
    func forgotPasswordSucceed()
    func forgotPasswordFailed(error: FirebaseError)
}

final class LoginInteractor {
    weak var presenter: LoginInteractorOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension LoginInteractor: LoginInteractorInputs {
    
    func login(email: String, password: String) {
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
    
    func forgotPassword(email: String) {
        authManager?.resetPassword(with: email) { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.forgotPasswordSucceed()
            case .failure(let error):
                presenter?.forgotPasswordFailed(error: error)
            }
        }
    }
    
    func googleSignIn() {
        authManager?.signInWithGoogle { [weak self] results in
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
