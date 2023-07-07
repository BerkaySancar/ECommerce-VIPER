//
//  RootWindowManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol RootWindowManagerProtocol {
    func changeRootViewController(_ viewController: UIViewController, animated: Bool) 
}

final class RootWindowManager: RootWindowManagerProtocol {
    
    static let shared = RootWindowManager()
    
    internal var window: UIWindow?
    
    private init() {}
    
    func changeRootViewController(_ viewController: UIViewController, animated: Bool) {
        guard let window = window else {
            return
        }
        
        if animated {
                    UIView.transition(
                        with: window,
                        duration: 0.5,
                        options: [.transitionFlipFromLeft],
                        animations: nil,
                        completion: nil
                    )
                }
        
        window.rootViewController = viewController
    }
}
