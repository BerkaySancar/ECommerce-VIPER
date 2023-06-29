//
//  ProductsService.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

typealias ProductsAndCategoriesHandler = (Result<(products: [ProductModel], categories: Categories), NetworkError>) -> Void
typealias CategoryProductsHandler = (Result<[ProductModel], NetworkError>) -> Void

protocol ProductsServiceProtocol {
    func fetchProductsAndCategories(completion: @escaping ProductsAndCategoriesHandler) async throws
    func fetchCategoryProducts(category: String, completion: @escaping CategoryProductsHandler) async throws
}

final class ProductsService {
    
    static let shared = ProductsService()
    
    private init() {}
    
    private let networkManager = NetworkManager.shared
}

extension ProductsService: ProductsServiceProtocol {
  
    func fetchProductsAndCategories(completion: @escaping ProductsAndCategoriesHandler) async throws {
        let group = DispatchGroup()
        var products: [ProductModel] = []
        var categories: Categories = []
        
        group.enter()
        do {
            let endpoint = ProductsEndpoint.allProducts
            let decodedProducts: [ProductModel] = try await networkManager.request(endpoint: endpoint)
            products = decodedProducts
            group.leave()
        } catch let error as NetworkError {
            group.leave()
            print(error.localizedDescription) // for debug
            throw error
        }
        
        group.enter()
        do {
            let endpoint = ProductsEndpoint.categories
            let decodedCategories: Categories = try await networkManager.request(endpoint: endpoint)
            categories = decodedCategories
            group.leave()
        } catch let error as NetworkError {
            group.leave()
            print(error.localizedDescription) // for debug
            throw error
        }
        
        group.notify(queue: .main) { 
            completion(.success((products, categories)))
        }
    }
    
    func fetchCategoryProducts(category: String, completion: @escaping CategoryProductsHandler) async throws {
        do {
            let endpoint = ProductsEndpoint.category(category)
            let products: [ProductModel] = try await networkManager.request(endpoint: endpoint)
            completion(.success(products))
        } catch let error as NetworkError {
            print(error.localizedDescription)
            throw error
        }
    }
}
