//
//  MockAuthManager.swift
//  ECommerceTests
//
//  Created by Berkay Sancar on 13.07.2023.
//

import Foundation
@testable import ECommerce

final class MockAuthManager: AuthManagerProtocol {
    
    var invokedLogin = false
    var invokedLoginCount = 0
    var invokedLoginParamsList = [(email: String, password: String)]()
    func login(email: String, password: String, completion: @escaping (Result<Void, ECommerce.FirebaseError>) -> Void) {
        invokedLogin = true
        invokedLoginCount += 1
        invokedLoginParamsList.append((email, password))
        completion(.success(()))
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, ECommerce.FirebaseError>) -> Void) {
        
    }
    
    func resetPassword(with email: String, completion: @escaping (Result<Void, ECommerce.FirebaseError>) -> Void) {
        
    }
    
    func signOut(completion: (Result<Void, ECommerce.FirebaseError>) -> Void) {
        
    }
    
    func signInWithGoogle(completion: @escaping (Result<Void, ECommerce.FirebaseError>) -> Void) {
        
    }
    
    
}
