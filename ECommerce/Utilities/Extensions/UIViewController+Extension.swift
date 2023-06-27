//
//  UIViewController+Extension.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import Foundation
import SPAlert
import UIKit.UIViewController

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alertView = SPAlertView(title: title, message: message, preset: title.isEmpty ? .error : .done)
        alertView.duration = TimeInterval(3)
        alertView.present()
    }
}
