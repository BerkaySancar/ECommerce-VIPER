//
//  MockHomeInteractor.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 25.07.2023.
//

import Foundation
@testable import ECommerce

final class MockHomeInteractor: HomeInteractorInputs {
    
    var invokedGetData = false
    var invokedGetDataCount = 0
    func getData() {
        invokedGetData = true
        invokedGetDataCount += 1
    }
    
    var invokedShowProducts = false
    var invokedShowProductsCount = 0
    func showProducts() -> [ECommerce.ProductModel] {
        invokedShowProducts = true
        invokedShowProductsCount += 1
        return [.init(id: 1, title: "title", price: 1, description: "description", category: "category", image: "image", rating: .init(rate: 1, count: 1))]
    }
    
    var invokedShowCategories = false
    var invokedShowCategoriesCount = 0
    func showCategories() -> ECommerce.Categories {
        invokedShowCategories = true
        invokedShowCategoriesCount += 1
        return ["a"]
    }
    
    var invokedGetUserInfos = false
    var invokedGetUserInfosCount = 0
    func getUserProfilePictureAndEmail() {
        invokedGetUserInfos = true
        invokedGetUserInfosCount += 1
    }
    
    var invokedSearchTextDidChange = false
    var invokedSearchTextDidChangeCount = 0
    var invokedSearchTextDidChangeParameter: String?
    func searchTextDidChange(text: String) {
        invokedSearchTextDidChange = true
        invokedSearchTextDidChangeCount += 1
        invokedSearchTextDidChangeParameter = text
    }
    
    var invokedGetCatProducts = false
    var invokedGetCatProductsCount = 0
    var invokedGetCatProductsParameter: String?
    func getCategoryProducts(category: String) {
        invokedGetCatProducts = true
        invokedGetCatProductsCount += 1
        invokedGetCatProductsParameter = category
    }
    
    var invokedGetFavorites = false
    var invokedGetFavoritesCount = 0
    func getFavorites() {
        invokedGetFavorites = true
        invokedGetFavoritesCount += 1
    }
    
    var invokedFavAction = false
    var invokedFavActionCount = 0
    var invokedFavActionParameter: ECommerce.ProductModel?
    func favAction(model: ECommerce.ProductModel?) {
        invokedFavAction = true
        invokedFavActionCount += 1
        invokedFavActionParameter = model
    }
    
    var invokedIsFav = false
    var invokedIsFavCount = 0
    var invokedIsFavParameter: ProductModel?
    func isFav(model: ECommerce.ProductModel?) -> Bool {
        invokedIsFav = true
        invokedIsFavCount += 1
        invokedIsFavParameter = model
        return false
    }
}
