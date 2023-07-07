//
//  UserInfoManager.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

protocol UserInfoManagerProtocol {
    func getUserProfilePictureAndEmail(completion: @escaping (_ photo: String?, _ email: String?) -> Void)
    func getUserUid() -> String?
}

final class UserInfoManager {
    
    static let shared = UserInfoManager()
    private init() {}
    
}

extension UserInfoManager: UserInfoManagerProtocol {
    func getUserProfilePictureAndEmail(completion: @escaping (_ photo: String?, _ email: String?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let profileImageURL = currentUser.photoURL
            completion(profileImageURL?.absoluteString, currentUser.email)
        } else {
            completion(nil, nil)
        }
    }
    
    func getUserUid() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
