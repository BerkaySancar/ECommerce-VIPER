//
//  OnboardingInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import Foundation

protocol OnboardingInteractorInputs {
    
}

protocol OnboardingInteractorOutputs: AnyObject {
    
}

final class OnboardingInteractor {
    weak var presenter: OnboardingInteractorOutputs?
}

extension OnboardingInteractor: OnboardingInteractorInputs {
    
}
