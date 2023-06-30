//
//  MainTabBarInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol MainTabBarInteractorInputs {
    
}

protocol MainTabBarInteractorOutputs: AnyObject {

}

final class MainTabBarInteractor {
    weak var presenter: MainTabBarInteractorOutputs?
}

extension MainTabBarInteractor: MainTabBarInteractorInputs {
    
}
