//
//  CountryModel.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation

typealias Countries = [Country]

struct Country: Codable {
    let name: CountryName
}

struct CountryName: Codable {
    let common: String
}
