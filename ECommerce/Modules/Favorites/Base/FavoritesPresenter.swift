//
//  FavoritesPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol FavoritesPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> FavoriteProductModel?
    func deleteItemForRowAt(indexPath: IndexPath)
    func didSelectRowAt(indexPath: IndexPath)
    func heightForRowAt() -> CGFloat
    func trashButtonTapped()
    func deleteAllFavorites()
    func jumpToHomeTapped()
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
        interactor?.getFavorites()
    }
    
    func viewWillAppear() {
        view?.setNavBarAndTabBarVisibility()
    }
    
    func numberOfRowsInSection() -> Int {
        return interactor?.showFavorites().count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> FavoriteProductModel? {
        return interactor?.showFavorites()[indexPath.row]
    }
    
    func deleteItemForRowAt(indexPath: IndexPath) {
        interactor?.deleteItemForRowAt(indexPath: indexPath)
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        if let productId = interactor?.showFavorites()[indexPath.item].productId {
            router?.toDetail(productId: productId)
        }
    }
    
    func heightForRowAt() -> CGFloat {
        return 150
    }
    
    func trashButtonTapped() {
        view?.presentTrashAllAlert()
    }
    
    func deleteAllFavorites() {
        interactor?.deleteAll()
    }
    
    func jumpToHomeTapped() {
        router?.toHome()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputs {
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func onError(message: String) {
        view?.onError(message: message)
    }
}
