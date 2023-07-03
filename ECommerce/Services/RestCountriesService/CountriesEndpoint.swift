//
//  CountriesEndpoint.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation

enum CountriesEndpoint: EndpointProtocol {
    
    case getAllCountries
    
    var baseURL: URL {
        guard let url = URL(string: "https://restcountries.com/v3.1") else {
            fatalError("countries url failed")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getAllCountries:
            return "/all"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllCountries:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getAllCountries:
            return nil
        }
    }
        
    
}
