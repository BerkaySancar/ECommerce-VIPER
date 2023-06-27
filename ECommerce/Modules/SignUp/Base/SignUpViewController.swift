//
//  SignUpViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import UIKit

protocol SignUpViewProtocol: AnyObject {
    func presentAlert(title: String, message: String)
}

final class SignUpViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    internal var presenter: SignUpPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func signUpTapped(_ sender: Any) {
        presenter.signUpTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @IBAction private func toLoginTapped(_ sender: Any) {
        presenter.toLoginTapped()
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    func presentAlert(title: String, message: String) {
        showAlert(title: title, message: message) //from extension
    }
}
