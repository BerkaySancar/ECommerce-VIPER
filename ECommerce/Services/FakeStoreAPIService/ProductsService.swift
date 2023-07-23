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
    private let networkManager = NetworkManager()
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
            print("Fetch all products error: \(error.localizedDescription)")
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
            print("Fetch categories error: \(error.localizedDescription)")
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
            print("Fetch category products error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchProduct(id: Int, completion: @escaping SingleProductHandler) async throws {
        do {
            let endpoint = ProductsEndpoint.getProduct(id)
            let product: ProductModel = try await networkManager.request(endpoint: endpoint)
            completion(.success(product))
        } catch let error as NetworkError {
            print("Fetch product error: \(error.localizedDescription)")
            throw error
        }
    }
}
