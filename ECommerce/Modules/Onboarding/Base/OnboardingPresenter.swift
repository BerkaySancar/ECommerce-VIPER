//
//  OnboardingPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import Foundation

protocol OnboardingPresenterInputs {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func cellForItemAtIndexPath(indexPath: IndexPath) -> OnboardCellViewModel
    func cellNextStartButtonTapped(title: String)
}

final class OnboardingPresenter {
    
    private weak var view: OnboardingViewProtocol?
    private let interactor: OnboardingInteractorInputs?
    private let router: OnboardingRouterProtocol?
    
    private var onboardings: [OnboardCellViewModel] = [] 
    
    init(view: OnboardingViewProtocol, interactor: OnboardingInteractorInputs, router: OnboardingRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Onboarding Presenter Inputs
extension OnboardingPresenter: OnboardingPresenterInputs {
    func viewDidLoad() {
        view?.setupConstraints()
        interactor?.createOnboardingItems()
    }
    
    func numberOfItemsInSection() -> Int {
        self.onboardings.count
    }
    
    func cellForItemAtIndexPath(indexPath: IndexPath) -> OnboardCellViewModel {
        return self.onboardings[indexPath.item]
    }
    
    func cellNextStartButtonTapped(title: String) {
        if title.contains("Next") {
            view?.scrollToNextItem()
        } else {
            router?.toLogin()
        }
    }
}

// MARK: - Onboarding Interactor To Presenter
extension OnboardingPresenter: OnboardingInteractorOutputs {
    func showOnboardingItems(items: [OnboardCellViewModel]) {
        self.onboardings = items
    }
}
