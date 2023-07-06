//
//  PaymentInfoPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation

protocol PaymentInfoPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func plusButtonTapped()
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) -> CardModel?
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func trashTapped(model: CardModel?)
    func toAddButtonTapped()
}

final class PaymentInfoPresenter {
    private weak var view: PaymentInfoViewProtocol?
    private let router: PaymentInfoRouterProtocol?
    private let interactor: PaymentInfoInteractorInputs?
    
    init(view: PaymentInfoViewProtocol, router: PaymentInfoRouterProtocol, interactor: PaymentInfoInteractorInputs) {
        self.view = view
        self.router = router
        self.interactor = interactor
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.notificationReceived(_:)),
                                               name: .cardAddButtonNotification,
                                               object: nil)
    }
}

extension PaymentInfoPresenter: PaymentInfoPresenterInputs {
 
    func viewDidLoad() {
        view?.setNavTitle(title: "My Cards")
        view?.setBackgrodunColor(color: .systemBackground)
        view?.prepareCollectionView()
        view?.prepareEmptyCardView()
        view?.preparePlusButton()
    }
    
    func viewWillAppear() {
        interactor?.getCards()
    }
    
    func plusButtonTapped() {
        router?.toAddCard(card: nil)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return interactor?.showCards()?.count ?? 0
    }
    
    func cellForItemAt(indexPath: IndexPath) -> CardModel? {
        return interactor?.showCards()?[indexPath.item]
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreenBounds.width - 32, height: 100)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        let selectedCard = interactor?.showCards()?[indexPath.item]
        router?.toAddCard(card: selectedCard)
    }
    
    @objc
    func notificationReceived(_ notification: Notification) {
        guard let cardInfos = notification.userInfo?["card"] else { return }
        guard let action = notification.userInfo?["action"] else { return }
  
        if action as! String == "add" {
            interactor?.addAction(model: cardInfos as! [String: Any])
        } else {
            interactor?.updateAction(model: cardInfos as! [String: Any])
        }
    }
    
    func trashTapped(model: CardModel?) {
        interactor?.deleteAction(model: model)
    }
    
    func toAddButtonTapped() {
        router?.toAddCard(card: nil)
    }
}

extension PaymentInfoPresenter: PaymentInfoInteractorOutputs {
    
    func onError(error: RealmError) {
        view?.onError(message: error.localizedDescription)
    }
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
}
