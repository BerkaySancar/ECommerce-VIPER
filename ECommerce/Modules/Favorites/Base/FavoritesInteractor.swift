//
//  FavoritesInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

protocol FavoritesInteractorInputs {
    func getFavorites()
    func showFavorites() -> [FavoriteProductModel]
    func deleteItemForRowAt(indexPath: IndexPath)
    func deleteAll()
}

protocol FavoritesInteractorOutputs: AnyObject {
    func dataRefreshed()
    func onError(message: String)
}

final class FavoritesInteractor {
    weak var presenter: FavoritesInteractorOutputs?
    private let storageManager: RealmManagerProtocol?
    
    private var favorites: [FavoriteProductModel] = [] {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    init(storageManager: RealmManagerProtocol) {
        self.storageManager = storageManager
    }
}

extension FavoritesInteractor: FavoritesInteractorInputs {
    
    func getFavorites() {
        self.favorites = storageManager?.getAll(FavoriteProductModel.self) ?? []
    }
    
    func showFavorites() -> [FavoriteProductModel] {
        return self.favorites
    }
    
    func deleteItemForRowAt(indexPath: IndexPath) {
        storageManager?.delete(self.favorites[indexPath.row]) { [weak self] error in
            guard let self else { return }
            presenter?.onError(message: error.localizedDescription)
        }
        self.favorites.remove(at: indexPath.row)
    }
    
    func deleteAll() {
        for favorite in favorites {
            storageManager?.delete(favorite) { [weak self] error in
                guard let self else { return }
                presenter?.onError(message: error.localizedDescription)
            }
        }
        self.favorites.removeAll()
    }
}
