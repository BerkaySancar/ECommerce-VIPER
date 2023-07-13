//
//  MockLoginInteractor.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 11.07.2023.
//

import Foundation
@testable import ECommerce

final class MockLoginInteractor: LoginInteractorInputs {

    var invokedLogin = false
    var invokedLoginCount = 0
    var invokedLoginParamsList = [(email: String, password: String)]()
    func login(email: String, password: String) {
        invokedLogin = true
        invokedLoginCount += 1
        invokedLoginParamsList.append((email: email, password: password))
    }
    
    var invokedForgotPassword = false
    var invokedForgotPasswordCount = 0
    var invokedForgotPasswordParamsList = [(email: String, Void)]()
    func forgotPassword(email: String) {
        invokedForgotPassword = true
        invokedForgotPasswordCount += 1
        invokedForgotPasswordParamsList.append((email, ()))
    }
    
    var invokedGoogleSignIn = false
    var invokedGoogleSignInCount = 0
    func googleSignIn() {
        invokedGoogleSignIn = true
        invokedGoogleSignInCount += 1
    }
}
