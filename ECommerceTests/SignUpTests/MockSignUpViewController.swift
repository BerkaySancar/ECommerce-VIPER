//
//  MockSignUpViewController.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 24.07.2023.
//

import Foundation
@testable import ECommerce

final class MockSignUpViewController: SignUpViewProtocol {
    
    var invokedPresentAlert = false
    var invokedPresentAlertCount = 0
    var invokedPresentAlertParams = [(title: String, message: String)]()
    func presentAlert(title: String, message: String) {
        invokedPresentAlert = true
        invokedPresentAlertCount += 1
        invokedPresentAlertParams.append((title, message))
    }
}
