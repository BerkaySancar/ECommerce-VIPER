//
//  FirebaseError.swift
//  ECommerce
//
//  Created by Berkay Sancar on 26.06.2023.
//

import Foundation

enum FirebaseError: Error {
    case loginError
    case signUpError
    case sendEmailError
    case signOutError
    case emailNotVerified
    
    var localizedDescription: String {
        switch self {
        case .loginError:
            return NSLocalizedString("Login failed. Try again.", comment: "")
        case .signUpError:
            return NSLocalizedString("Something went wrong. Try again.", comment: "")
        case .sendEmailError:
            return NSLocalizedString("Unable to send authentication email.", comment: "")
        case .signOutError:
            return NSLocalizedString("Sign out failed. Try again.", comment: "")
        case .emailNotVerified:
            return NSLocalizedString("Email not verified. Please check your email and verify your account.", comment: "")
        }
    }
}

