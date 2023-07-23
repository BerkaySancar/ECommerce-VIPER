//
//  UITabBarController+Extension.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation
import UIKit.UITabBarController

extension UITabBarController {
    
    func setController(viewController: UIViewController, title: String, imageName: String, selectedImageName: String) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: imageName)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        return UINavigationController(rootViewController: viewController)
    }
}
