//
//  PaymentInfoRouter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation
import UIKit.UIViewController

protocol PaymentInfoRouterProtocol {
    func toAddCard(card: CardModel?)
}

final class PaymentInfoRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
    static func startPaymentInfoModule() -> UIViewController {
        let view = PaymentInfoViewController()
        let router = PaymentInfoRouter(view: view)
        let interactor = PaymentInfoInteractor(storageManager: RealmManager.shared)
        let presenter = PaymentInfoPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}

extension PaymentInfoRouter: PaymentInfoRouterProtocol {
    
    func toAddCard(card: CardModel?) {
        let addCardViewController = AddCardViewController(card: card)
        self.view?.navigationController?.pushViewController(addCardViewController, animated: true)
    }
}
