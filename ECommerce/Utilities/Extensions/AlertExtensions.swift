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
        alertView.duration = TimeInterval(2)
        alertView.present()
    }
    
    func passwordResetAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Password Reset", message: "Enter your email adress", preferredStyle: .alert)
        alertController.view.tintColor = .label
        
        alertController.addTextField { textField in
            textField.placeholder = "Email"
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .default) { _ in
            guard let email = alertController.textFields?.first?.text else { return }
            completion(email)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(resetAction)
        alertController.addAction(cancelAction)
        
        navigationController?.present(alertController, animated: true)
    }
    
    func deleteAllSheetAlert(completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Delete All", message: "Are you sure you want to delete them all?", preferredStyle: .actionSheet)
        alertController.view.tintColor = .label
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAllAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAllAction)
        
        navigationController?.present(alertController, animated: true)
    }
}
