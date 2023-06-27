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
    func forgotPasswordTapped(email: String)
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

// MARK: - Login Presenter Inputs
extension LoginPresenter: LoginPresenterInputs {
    func viewDidLoad() {
        
    }
    
    func loginButtonTapped(email: String?, password: String?) {
        guard let email,
              let password,
              !email.isEmpty,
              !password.isEmpty
        else {
            view?.presentAlert(title: "", message: GeneralError.emailPasswordEmpty.localizedDescription)
            return
        }
        
        interactor?.login(email: email, password: password)
    }
    
    func signUpButtonTapped() {
        router?.toSignUp()
    }
    
    func forgotPasswordTapped(email: String) {
        interactor?.forgotPassword(email: email)
    }
}

// MARK: - Login Interactor to Presenter

extension LoginPresenter: LoginInteractorOutputs {
    func loginFailed(error: FirebaseError) {
        view?.presentAlert(title: "", message: error.localizedDescription)
    }
    
    func loginSucceed() {
        router?.toHome()
    }
    
    func forgotPasswordSucceed() {
        view?.presentAlert(title: "Success", message: "Reset email send.")
    }
    
    func forgotPasswordFailed(error: FirebaseError) {
        view?.presentAlert(title: "", message: error.localizedDescription)
    }
}
