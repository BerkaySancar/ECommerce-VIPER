//
//  MockHomeRouter.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 25.07.2023.
//

import Foundation
@testable import ECommerce

final class MockHomeRouter: HomeRouterProtocol {
    
    var invokedToDetail = false
    var invokedToDetailCount = 0
    var invokedToDetailParameter: Int?
    func toDetail(id: Int) {
        invokedToDetail = true
        invokedToDetailCount += 1
        invokedToDetailParameter = id
    }
}
