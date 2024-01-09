//
//  NetworkManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation
import SystemConfiguration

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    
    var isReachable: Bool {
        return checkReachability()
    }
    
    private init() {}
    
    func checkReachability() -> Bool {
        if let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com") {
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
            SCNetworkReachabilityGetFlags(reachability, &flags)
            
            return flags.contains(.reachable) && !flags.contains(.connectionRequired)
        }
        return false
    }
    
    func request<T: Codable>(_ endpoint: EndpointProtocol, type: T.Type) async throws -> T? {
        if isReachable {
            guard let (data, response) = try? await URLSession.shared.data(for: endpoint.urlRequest()) else { throw NetworkError.invalidURL }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    let decodedData = try? decoder.decode(T.self, from: data)
                    return decodedData
                case 401:
                    throw NetworkError.unauthorized
                default:
                    throw NetworkError.invalidResponse
                }
            }
        } else {
            throw NetworkError.noConnection
        }
        
        return nil
    }
}
