//
//  LoginPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

protocol LoginPresenterInputs {
    func viewDidLoad()
    func loginButtonTapped(email: String?, password: String?)
    func signUpButtonTapped()
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
    func viewDidLoad() {
        
    }
    
    func loginButtonTapped(email: String?, password: String?) {
        guard let email,
              let password,
              !email.isEmpty,
              !password.isEmpty
        else {
            view?.alert(title: "", message: GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        
        interactor?.loginTapped(email: email, password: password)
    }
    
    func signUpButtonTapped() {
        router?.toSignUp()
    }
}

extension LoginPresenter: LoginInteractorOutputs {
    func loginFailed(error: FirebaseError) {
        view?.alert(title: "", message: error.localizedDescription)
    }
    
    func loginSucceed() {
        router?.toHome()
    }
}
