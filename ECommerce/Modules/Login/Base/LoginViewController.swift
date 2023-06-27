//
//  LoginViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func alert(title: String, message: String)
}

final class LoginViewController: UIViewController {
    
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    internal var presenter: LoginPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        presenter.loginButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        presenter.signUpButtonTapped()
    }
    
}

extension LoginViewController: LoginViewProtocol {
    func alert(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}
