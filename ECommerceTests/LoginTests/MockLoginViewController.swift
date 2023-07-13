//
//  MockLoginViewController.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 11.07.2023.
//

import Foundation
@testable import ECommerce

final class MockLoginViewController: LoginViewProtocol {
    
    var invokedPresentAlert = false
    var invokedPresentAlertCount = 0
    var invokedPresentAlertParamsList = [(title: String, message: String)]()
    func presentAlert(title: String, message: String) {
        invokedPresentAlert = true
        invokedPresentAlertCount += 1
        invokedPresentAlertParamsList.append((title, message))
    }
}
