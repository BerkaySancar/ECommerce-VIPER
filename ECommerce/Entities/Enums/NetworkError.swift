//
//  NetworkError.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidURLRequest
    case requestFailed
    case noConnection
    case unauthorized
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL.", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid response.", comment: "")
        case .requestFailed:
            return NSLocalizedString("Request failed.", comment: "")
        case .invalidURLRequest:
            return NSLocalizedString("Invalid URL Request.", comment: "")
        case .noConnection:
            return NSLocalizedString("No internet connection.", comment: "")
        case .unauthorized:
            return NSLocalizedString("Unauthorized request.", comment: "")
        }
    }
}
