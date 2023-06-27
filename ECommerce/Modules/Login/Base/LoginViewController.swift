//
//  LoginViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func presentAlert(title: String, message: String)
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    internal var presenter: LoginPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
// MARK: - Actions
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        presenter.loginButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        presenter.signUpButtonTapped()
    }
    
    @IBAction private func forgotPasswordTapped(_ sender: UIButton) {
        /// Present AlertController with TextField from extension
        passwordResetAlert { [weak self] email in
            guard let self else { return }
            self.presenter.forgotPasswordTapped(email: email)
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    func presentAlert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}
