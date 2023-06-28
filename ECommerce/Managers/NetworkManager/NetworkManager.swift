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
            
    func request<T: Codable>(endpoint: EndpointProtocol) async throws -> T {
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
}

