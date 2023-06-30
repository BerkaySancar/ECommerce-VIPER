//
//  FavoritesPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol FavoritesPresenterInputs {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func heightForRowAt() -> CGFloat
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
    
    func viewDidLoad() {
        view?.setNavTitle(title: "Favorites")
        view?.prepareTrashBarButton()
        view?.prepareTableView()
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func heightForRowAt() -> CGFloat {
        return 150
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputs {
    
}
