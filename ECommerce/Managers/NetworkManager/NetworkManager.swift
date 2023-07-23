//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

final class NetworkManager {
   
    func request<T: Codable>(endpoint: EndpointProtocol? = nil, urlRequest: URLRequest? = nil) async throws -> T {
        let finalURLRequest: URLRequest
        
        if let endpoint {
            finalURLRequest = endpoint.urlRequest()
        } else if let urlRequest {
            finalURLRequest = urlRequest
        } else {
            throw NetworkError.invalidURLRequest
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

