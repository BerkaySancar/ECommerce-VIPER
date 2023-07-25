//
//  MockSignUpRouter.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 24.07.2023.
//

import Foundation
@testable import ECommerce

final class MockSignUpRouter: SignUpRouterProtocol {
    
    var invokedToLogin = false
    var invokedToLoginCount = 0
    func toLogin() {
        invokedToLogin = true
        invokedToLoginCount += 1
    }
}
