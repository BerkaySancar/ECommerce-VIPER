//
//  MockOnboardingViewController.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 23.07.2023.
//

import Foundation
@testable import ECommerce

final class MockOnboardingViewController: OnboardingViewProtocol {
    
    var invokedSetupConstraint = false
    var invokedSetupConstraintCount = 0
    func setupConstraints() {
        invokedSetupConstraint = true
        invokedSetupConstraintCount += 1
    }
    
    var invokedScrollToNextItem = false
    var invokedScrollToNextItemCount = 0
    func scrollToNextItem() {
        invokedScrollToNextItem = true
        invokedScrollToNextItemCount += 1
    }
}
