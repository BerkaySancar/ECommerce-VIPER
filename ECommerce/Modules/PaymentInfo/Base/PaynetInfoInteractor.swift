//
//  PaynetInfoInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation

protocol PaymentInfoInteractorInputs {
    func getCards()
    func showCards() -> [CardModel]?
    func addAction(model: [String: Any])
    func updateAction(model: [String: Any])
    func deleteAction(model: CardModel?)
}

protocol PaymentInfoInteractorOutputs: AnyObject {
    func onError(error: RealmError)
    func dataRefreshed()
}

final class PaymentInfoInteractor {
    weak var presenter: PaymentInfoInteractorOutputs!
    private let storageManager: RealmManagerProtocol?
    
    private var cards: [CardModel]?
    
    init(storageManager: RealmManagerProtocol) {
        self.storageManager = storageManager
    }
}

extension PaymentInfoInteractor: PaymentInfoInteractorInputs {
    
    func getCards() {
        self.cards = storageManager?.getAll(CardModel.self).filter { $0.userId == UserInfoManager.shared.getUserUid() }
    }
    
    func showCards() -> [CardModel]? {
        return self.cards
    }
    
    func addAction(model: [String : Any]) {
        let card = CardModel(userId: model["userId"] as! String,
                             uuid: model["uuid"] as! String,
                             nameSurname: model["nameSurname"] as! String,
                             cardName: model["cardName"] as! String,
                             cardNumber: model["cardNumber"] as! String,
                             month: model["month"] as! String,
                             year: model["year"] as! String,
                             cvv: model["cvv"] as! String)
        
        storageManager?.create(card) { [weak self] error in
            guard let self else { return }
            self.presenter.onError(error: error)
        }
        presenter?.dataRefreshed()
    }
    
    func updateAction(model: [String : Any]) {
        guard let savedCard = self.cards?.filter({ $0.uuid == (model["uuid"] as! String) }).first else { return }
        
        storageManager?.update(savedCard, with: model, onError: { [weak self] error in
            guard let self else { return }
            self.presenter?.onError(error: error)
        })
        self.presenter?.dataRefreshed()
    }
    
    func deleteAction(model: CardModel?) {
        if let model {
            if let index = self.cards?.firstIndex(where: { $0.uuid == model.uuid }) {
                storageManager?.delete(model, onError: { [weak self] error in
                    guard let self else { return }
                    self.presenter?.onError(error: error)
                })
                self.cards?.remove(at: index)
                self.presenter.dataRefreshed()
            }
        }
    }
}
