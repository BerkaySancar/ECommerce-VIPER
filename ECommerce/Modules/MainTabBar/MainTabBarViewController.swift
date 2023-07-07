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
    func setBasketItemsBadgeValue(value: Int)
}

final class MainTabBarViewController: UITabBarController {
    
    private let homeModule = HomeRouter.startHomeModule()
    private let favoritesModule = FavoritesRouter.startFavoritesModule()
    private let basketModule = BasketRouter.startBasketModule()
    private let profileModule = ProfileRouter.startProfileModule()
    
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
                
                setController(viewController: favoritesModule,
                              title: "Favorites",
                              imageName: "heart",
                              selectedImageName: "heart.fill"),
                
                setController(viewController: basketModule,
                              title: "Basket",
                              imageName: "basket",
                              selectedImageName: "basket.fill"),
                
                setController(viewController: profileModule,
                              title: "Profile",
                              imageName: "person",
                              selectedImageName: "person.fill"),
            ],
                           animated: true)
    }
  
    func setBasketItemsBadgeValue(value: Int) {
        self.basketModule.tabBarItem.badgeValue = String(value)
    }
}
