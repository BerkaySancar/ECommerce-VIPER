//
//  GeneralError.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import Foundation

enum GeneralError: Error {
    
    case emailPasswordEmpty
    
    var localizedDescription: String {
        switch self {
        case .emailPasswordEmpty:
            return NSLocalizedString("Email & Password cannot be empty!", comment: "")
        }
    }
}
