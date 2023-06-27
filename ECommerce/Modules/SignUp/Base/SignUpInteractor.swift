//
//  SignUpInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol SignUpInteractorInputs {
    func signUpTapped(email: String, password: String)
}

protocol SignUpInteractorOutputs: AnyObject {
    func signUpSucceed()
    func signUpFailed(error: FirebaseError)
}

final class SignUpInteractor {
    weak var presenter: SignUpInteractorOutputs?
    private let authManager: AuthManagerProtocol?
    
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension SignUpInteractor: SignUpInteractorInputs {
    
    func signUpTapped(email: String, password: String) {
        authManager?.signUp(email: email, password: password) { [weak self] results in
            guard let self else { return }
            
            switch results {
            case .success(_):
                presenter?.signUpSucceed()
            case .failure(let error):
                presenter?.signUpFailed(error: error)
            }
        }
    }
}
