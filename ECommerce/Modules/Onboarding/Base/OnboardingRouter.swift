//
//  OnboardingRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import Foundation
import UIKit

protocol OnboardingRouterProtocol {
    func toLogin()
}

final class OnboardingRouter {
    
    private weak var view: UIViewController?
    private let windowManager: RootWindowManagerProtocol?
    
    init(view: UIViewController, windowManager: RootWindowManagerProtocol) {
        self.view = view
        self.windowManager = windowManager
    }
    
    static func startOnboarding() -> UIViewController {
        let view = OnboardingViewController()
        let router = OnboardingRouter(view: view, windowManager: RootWindowManager.shared)
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension OnboardingRouter: OnboardingRouterProtocol {
    
    func toLogin() {
        let loginModule = UINavigationController(rootViewController: LoginRouter.startLogin())
        windowManager?.changeRootViewController(loginModule, animated: true)
    }
}
