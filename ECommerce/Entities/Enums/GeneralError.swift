//
//  GeneralError.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import Foundation

enum GeneralError: Error {
    
    case emailPasswordEmpty
    case addressInfoMissing
    
    var localizedDescription: String {
        switch self {
        case .emailPasswordEmpty:
            return NSLocalizedString("Email & Password cannot be empty!", comment: "")
        case .addressInfoMissing:
            return NSLocalizedString("Information is missing!", comment: "")
        }
    }
}
