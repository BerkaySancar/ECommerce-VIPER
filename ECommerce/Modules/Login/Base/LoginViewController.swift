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
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    internal var presenter: LoginPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("tapped")
    }
}

extension LoginViewController: LoginViewProtocol {
    
}
