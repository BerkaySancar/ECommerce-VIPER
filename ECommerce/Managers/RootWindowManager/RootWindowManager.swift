//
//  RootWindowManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol RootWindowManagerProtocol {
    func changeRootViewController(_ viewController: UIViewController) 
}

final class RootWindowManager: RootWindowManagerProtocol {
    
    static let shared = RootWindowManager()
    
    internal var window: UIWindow?
    
    private init() {}
    
    func changeRootViewController(_ viewController: UIViewController) {
        guard let window = window else {
            return
        }
        
        window.rootViewController = viewController
    }
}
