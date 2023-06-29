//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
            
    func apiRequest<T: Codable>(endpoint: EndpointProtocol) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: endpoint.urlRequest()) else {
            throw NetworkError.invalidURL
        }
    
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.requestFailed
        }
        
        return decodedData
    }
    
    func urlRequest<T: Codable>(endpoint: EndpointProtocol?, urlRequest: URLRequest?) async throws -> T {
        
        let finalURLRequest: URLRequest
        if let endpoint = endpoint {
            finalURLRequest = endpoint.urlRequest()
        } else if let urlRequest = urlRequest {
            finalURLRequest = urlRequest
        } else {
            throw NetworkError.invalidURL
        }

        guard let (data, response) = try? await URLSession.shared.data(for: finalURLRequest) else {
            throw NetworkError.invalidURL
        }
        
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.requestFailed
        }
        
        return decodedData
    }
}

