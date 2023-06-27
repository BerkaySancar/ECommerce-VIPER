//
//  AuthManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func signOut(completion: (Result<Void, FirebaseError>) -> Void)
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init() {}
}

extension AuthManager: AuthManagerProtocol {
    
    func login(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error)  in
            if let error {
                debugPrint(error)
                completion(.failure(.loginError))
            } else {
                if let user = result?.user, user.isEmailVerified {
                    completion(.success(()))
                } else {
                    completion(.failure(.emailNotVerified))
                }
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error {
                debugPrint(error)
                completion(.failure(.signUpError))
            } else {
                result?.user.sendEmailVerification { error in
                    if let error {
                        debugPrint(error)
                        completion(.failure(.sendEmailError))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func signOut(completion: (Result<Void, FirebaseError>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.signOutError))
        }
    }
}
