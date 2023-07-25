//
//  MockOnboardingRouter.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 23.07.2023.
//

import Foundation
@testable import ECommerce

final class MockOnboardingRouter: OnboardingRouterProtocol {
    
    var invokedToLogin = false
    var invokedToLoginCount = 0
    func toLogin() {
        invokedToLogin = true
        invokedToLoginCount += 1
    }
}
