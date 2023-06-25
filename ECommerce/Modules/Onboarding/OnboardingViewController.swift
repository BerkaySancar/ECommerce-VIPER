//
//  OnboardingViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    
}

final class OnboardingViewController: UIViewController {
    
    var presenter: OnboardingPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}

extension OnboardingViewController: OnboardingViewProtocol {
    
}
