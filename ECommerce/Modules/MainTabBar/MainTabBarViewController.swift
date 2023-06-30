//
//  MainTabBarViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import UIKit

protocol MainTabBarViewProtocol: AnyObject {
    func configureTabBar()
    func setTabBarControllers()
}

final class MainTabBarViewController: UITabBarController {
    
    private let homeModule = HomeRouter.startHomeModule()
    
    internal var presenter: MainTabBarPresenterInputs!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension MainTabBarViewController: MainTabBarViewProtocol {
    
    func configureTabBar() {
        tabBar.backgroundColor = .systemGray5
        tabBar.tintColor = .label
        tabBar.layer.shadowOpacity = 0.75
        tabBar.layer.cornerRadius = 8
        tabBar.layer.shadowColor = UIColor.label.cgColor
    }
    
    func setTabBarControllers() {
        setViewControllers(
            [
                setController(viewController: homeModule,
                              title: "Home",
                              imageName: "house",
                              selectedImageName: "house.fill"),
                
                setController(viewController: UIViewController(),
                              title: "Favorites",
                              imageName: "heart",
                              selectedImageName: "heart.fill"),
                
                setController(viewController: UIViewController(),
                              title: "Basket",
                              imageName: "basket",
                              selectedImageName: "basket.fill"),
                
                setController(viewController: UIViewController(),
                              title: "Profile",
                              imageName: "person",
                              selectedImageName: "person.fill"),
            ],
                           animated: true)
    }
}
