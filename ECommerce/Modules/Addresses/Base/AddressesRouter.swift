//
//  AddressesRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol AddressesRouterProtocol {
    func toAddAddress()
}

final class AddressesRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    static func startAddressesModule() -> UIViewController {
        let view = AddressesViewController()
        let router = AddressesRouter(view: view)
        let interactor = AddressesInteractor(storageManager: RealmManager.shared)
        let presenter = AddressesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension AddressesRouter: AddressesRouterProtocol {
    func toAddAddress() {
        let addController = AddAddressViewController(address: nil)
        self.view?.navigationController?.pushViewController(addController, animated: true)
    }
}
