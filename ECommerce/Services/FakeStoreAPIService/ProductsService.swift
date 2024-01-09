//
//  ProductsService.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

typealias ProductsAndCategoriesHandler = (Result<(products: [ProductModel], categories: Categories), NetworkError>) -> Void
typealias CategoryProductsHandler = (Result<[ProductModel], NetworkError>) -> Void
typealias SingleProductHandler = (Result<ProductModel, NetworkError>) -> Void

protocol ProductsServiceProtocol {
    func fetchProductsAndCategories(completion: @escaping ProductsAndCategoriesHandler) async throws
    func fetchCategoryProducts(category: String, completion: @escaping CategoryProductsHandler) async throws
    func fetchProduct(id: Int, completion: @escaping SingleProductHandler) async throws
}

final class ProductsService {
    private let networkManager = NetworkManager.shared
    private let group = DispatchGroup()
}

extension ProductsService: ProductsServiceProtocol {

    func fetchProductsAndCategories(completion: @escaping ProductsAndCategoriesHandler) async throws {
        var products: [ProductModel] = []
        var categories: Categories = []
        
        group.enter()
        do {
            let endpoint = ProductsEndpoint.allProducts
            let decodedProducts = try await networkManager.request(endpoint, type: [ProductModel].self)
            products = decodedProducts ?? []
            group.leave()
        } catch let error as NetworkError {
            group.leave()
            completion(.failure(error))
            print("Fetch all products error: \(error.localizedDescription)")
            throw error
        }
        
        group.enter()
        do {
            let endpoint = ProductsEndpoint.categories
            let decodedCategories = try await networkManager.request(endpoint, type: Categories.self)
            categories = decodedCategories ?? []
            group.leave()
        } catch let error as NetworkError {
            group.leave()
            print("Fetch categories error: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
        }
        
        group.notify(queue: .main) { 
            completion(.success((products, categories)))
        }
    }
    
    func fetchCategoryProducts(category: String, completion: @escaping CategoryProductsHandler) async throws {
        do {
            let endpoint = ProductsEndpoint.category(category)
            let products = try await networkManager.request(endpoint, type: [ProductModel].self)
            completion(.success(products ?? []))
        } catch let error as NetworkError {
            print("Fetch category products error: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
        }
    }
    
    func fetchProduct(id: Int, completion: @escaping SingleProductHandler) async throws {
        do {
            let endpoint = ProductsEndpoint.getProduct(id)
            let product = try await networkManager.request(endpoint, type: ProductModel.self)
            if let product {
                completion(.success(product))
            }
        } catch let error as NetworkError {
            print("Fetch product error: \(error.localizedDescription)")
            completion(.failure(error))
            throw error
        }
    }
}
