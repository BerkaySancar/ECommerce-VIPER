//
//  FavoritesViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    
}

final class FavoritesViewController: UIViewController {
    
    internal var presenter: FavoritesPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    
}
