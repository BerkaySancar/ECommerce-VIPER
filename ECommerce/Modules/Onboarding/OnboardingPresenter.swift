//
//  OnboardingPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import Foundation

protocol OnboardingPresenterInputs {
    
}

final class OnboardingPresenter {
    
    private weak var view: OnboardingViewProtocol?
    private let interactor: OnboardingInteractorInputs?
    private let router: OnboardingRouterProtocol?
    
    init(view: OnboardingViewProtocol, interactor: OnboardingInteractorInputs, router: OnboardingRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    
}

extension OnboardingPresenter: OnboardingPresenterInputs {
    
}

extension OnboardingPresenter: OnboardingInteractorOutputs {
    
}
