//
//  FavoritesInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol FavoritesInteractorInputs {
    
}

protocol FavoritesInteractorOutputs: AnyObject {
    
}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorOutputs?
}

extension FavoritesInteractor: FavoritesInteractorInputs {
    
}
