//
//  MockOnboardingInteractor.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 23.07.2023.
//

import Foundation
@testable import ECommerce

final class MockOnboardingInteractor: OnboardingInteractorInputs {
  
    var invokedCreateOnboardingItems = false
    var invokedCreateOnboardingItemsCount = 0
    func createOnboardingItems() {
        invokedCreateOnboardingItems = true
        invokedCreateOnboardingItemsCount += 1
    }
    
    var invokedShowOnboardingItems = false
    var invokedShowOnboardingItemsCount = 0
    func showOnboardingItems() -> [ECommerce.OnboardCellViewModel]? {
        invokedShowOnboardingItems = true
        invokedShowOnboardingItemsCount += 1
        return [.init(image: .init(systemName: "house")!, title: "title", description: "descript", buttonTitle: "btnTitle")]
    }
}
