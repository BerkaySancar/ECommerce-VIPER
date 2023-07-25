//
//  MockSignUpInteractor.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 24.07.2023.
//

import Foundation
@testable import ECommerce

final class MockSignUpInteractor: SignUpInteractorInputs {
    
    var invokedSignUpTapped = false
    var invokedSignUpTappedCount = 0
    var invokedSignUpTappedParams = [(email: String, password: String)]()
    func signUpTapped(email: String, password: String) {
        invokedSignUpTapped = true
        invokedSignUpTappedCount += 1
        invokedSignUpTappedParams.append((email, password))
    }
}
