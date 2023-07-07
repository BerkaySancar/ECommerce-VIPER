//
//  ProfileRowItem.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIImage

enum ProfileRowItem {
    case address
    case payment
    case orderHistory
    case signOut
    
    var title: String {
        switch self {
        case .address:
            return "Address Information"
        case .payment:
            return "Payment Information"
        case .orderHistory:
            return "Order History"
        case .signOut:
            return "Sign Out"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .address:
            return UIImage(systemName: "map")
        case .payment:
            return UIImage(systemName: "creditcard")
        case .orderHistory:
            return UIImage(systemName: "wallet.pass")
        case .signOut:
            return UIImage(systemName: "power")
        }
    }
}
