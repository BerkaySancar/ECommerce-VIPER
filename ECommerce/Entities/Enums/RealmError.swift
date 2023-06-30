//
//  RealmError.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import Foundation

enum RealmError {
    
    case addFailed
    case updateFailed
    case deleteFailed
    
    var localizedDescription: String {
        switch self {
        case .addFailed:
            return NSLocalizedString("Product could not be added. Try again.", comment: "")
        case .updateFailed:
            return NSLocalizedString("Product could not be updated. Try again.", comment: "")
        case .deleteFailed:
            return NSLocalizedString("Product could not be deleted. Try again.", comment: "")
        }
    }
}
