//
//  CountriesServices.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation

protocol CountriesServiceProtocol: AnyObject {
    func getAllCountries(completion: @escaping (Result<Countries, NetworkError>) -> Void) async throws
}

final class CountriesService: CountriesServiceProtocol {
    
    private let networkManager = NetworkManager.shared
    
    func getAllCountries(completion: @escaping (Result<Countries, NetworkError>) -> Void) async throws {
        do {
            let endpoint = CountriesEndpoint.getAllCountries
            let countries = try await networkManager.request(endpoint, type: Countries.self)
            completion(.success(countries ?? []))
        } catch let error as NetworkError {
            completion(.failure(error))
        }
    }
}
