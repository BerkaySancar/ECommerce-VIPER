//
//  LoginViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    
}

final class LoginViewController: UIViewController {
    
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    internal var presenter: LoginPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty
        else {
            print("else")
            return
        }
        
        presenter.loginButtonTapped(email: email, password: password)
    }
}

extension LoginViewController: LoginViewProtocol {
    
}
