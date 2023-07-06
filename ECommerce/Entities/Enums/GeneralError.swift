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
    case cardInfoMissing
    
    var localizedDescription: String {
        switch self {
        case .emailPasswordEmpty:
            return NSLocalizedString("Email & Password cannot be empty!", comment: "")
        case .addressInfoMissing:
            return NSLocalizedString("Address informations are missing!", comment: "")
        case .cardInfoMissing:
            return NSLocalizedString("Card informations are missing!", comment: "")
        }
    }
}
