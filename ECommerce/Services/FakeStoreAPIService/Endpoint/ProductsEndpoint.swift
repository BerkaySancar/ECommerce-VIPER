//
//  ProductsEndpoints.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

enum ProductsEndpoint: EndpointProtocol {
    
    case allProducts
    case categories
    
    var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com") else {
            fatalError("url failed")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .allProducts:
            return "/products"
        case .categories:
            return "/products/categories"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .allProducts:
            return .get
        case .categories:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .allProducts:
            return nil
        case .categories:
            return nil
        }
    }
}
