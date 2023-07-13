//
//  MockLoginRouter.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 11.07.2023.
//

import Foundation
@testable import ECommerce

final class MockLoginRouter: LoginRouterProtocol {
    
    var invokedToSignUp = false
    var invokedToSignUpCount = 0
    func toSignUp() {
        invokedToSignUp = true
        invokedToSignUpCount += 1
    }
    
    var invokedToHome = false
    var invokedToHomeCount = 0
    func toHome() {
        invokedToHome = true
        invokedToHomeCount += 1
    }
}
