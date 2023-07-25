//
//  OnboardingInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import Foundation

protocol OnboardingInteractorInputs {
    func createOnboardingItems()
    func showOnboardingItems() -> [OnboardCellViewModel]?
}

protocol OnboardingInteractorOutputs: AnyObject {
    
}

final class OnboardingInteractor {
    weak var presenter: OnboardingInteractorOutputs?
    
    private var onboardingItems: [OnboardCellViewModel] = []
}

extension OnboardingInteractor: OnboardingInteractorInputs {
    
    func createOnboardingItems() {
        onboardingItems =
        [
            .init(image: .init(named: "onboarding1")!,
                  title: "Welcome to our Online Store!",
                  description: "Shop hassle-free with us. Explore a wide range of products, easy payments, and quick delivery.",
                  buttonTitle: "Next"),
            
            .init(image: .init(named: "onboarding2")!,
                  title: "Enjoy Shopping Experience",
                  description: "Browse our extensive collection, find your favorite items, and shop with confidence.",
                  buttonTitle: "Next"),
            
            .init(image: .init(named: "onboarding3")!,
                  title: "Shop Anytime, Anywhere",
                  description: "Experience the freedom of shopping on your terms. Our online store is accessible 24/7.",
                  buttonTitle: "Get Started")
        ]
    }
    
    func showOnboardingItems() -> [OnboardCellViewModel]? {
        return self.onboardingItems
    }
}
