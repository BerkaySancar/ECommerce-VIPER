//
//  FavoritesPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol FavoritesPresenterInputs {
    
}

final class FavoritesPresenter {
    private weak var view: FavoritesViewProtocol?
    private let interactor: FavoritesInteractorInputs?
    private let router: FavoritesRouterProtocol?
    
    init(view: FavoritesViewProtocol, interactor: FavoritesInteractorInputs, router: FavoritesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritesPresenter: FavoritesPresenterInputs {
    
}

extension FavoritesPresenter: FavoritesInteractorOutputs {
    
}
