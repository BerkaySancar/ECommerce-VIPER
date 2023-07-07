//
//  CompleteOrderPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import Foundation

protocol CompleteOrderPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) -> Array<Any>
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func completeButtonTapped()
    func addUpdateTappedFromCards()
    func addUpdateTappedFromAddresses()
    func showTotalAndDeliveryPrice() -> (price: Double, delivery: Double)?
    func didSelectCard(cardName: String)
    func didSelectAddress(addressName: String)
}

final class CompleteOrderPresenter {
    private weak var view: CompleteOrderViewProtocol?
    private let interactor: CompleteOrderInteractorInputs?
    private let router: CompleteOrderRouterProtocol?
    
    private var selectedCard: CardModel?
    private var selectedAddress: AddressModel?
    
    init(view: CompleteOrderViewProtocol, interactor: CompleteOrderInteractorInputs, router: CompleteOrderRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension CompleteOrderPresenter: CompleteOrderPresenterInputs {
   
    func viewDidLoad() {
        view?.setNavTitle(title: "Complete Order")
        view?.setBackgroundColor(color: .systemBackground)
        view?.setTabBarVisibility()
        view?.prepareCompleteButton()
        view?.prepareCollectionView()
    }
    
    func viewWillAppear() {
        interactor?.getCards()
        interactor?.getAddresses()
    }
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return 1
    }
    
    func cellForItemAt(indexPath: IndexPath) -> Array<Any> {
        if indexPath.section == 0 {
            return interactor?.showAddresses() as? [AddressModel] ?? []
        } else if indexPath.section == 1 {
            return interactor?.showCards() as? [CardModel] ?? []
        }
        return []
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: UIScreenBounds.width - 32, height: 180)
        } else if indexPath.section == 1 {
            return .init(width: UIScreenBounds.width - 32, height: 180)
        } else {
            return .init(width: UIScreenBounds.width - 32, height: 100)
        }
    }
    
    func showTotalAndDeliveryPrice() -> (price: Double, delivery: Double)? {
        return interactor?.showTotalAndDeliveryPrice()
    }
    
    func addUpdateTappedFromCards() {
        router?.toPaymentInfo()
    }
    
    func addUpdateTappedFromAddresses() {
        router?.toAddresses()
    }
    
    func didSelectCard(cardName: String) {
        let selectedCard = interactor?.showCards()?.filter { $0.cardName == cardName }.first
        self.selectedCard = selectedCard
    }
    
    func didSelectAddress(addressName: String) {
        let selectedAddress = interactor?.showAddresses()?.filter { $0.name == addressName }.first
        self.selectedAddress = selectedAddress
    }
    
    func completeButtonTapped() {
        if let selectedCard,
           let selectedAddress,
           selectedAddress.name != "",
           selectedCard.cardName != ""
        {
            interactor?.saveOrder(address: self.selectedAddress, card: self.selectedCard)
        } else {
            view?.presentAlert(title: "", message: GeneralError.emptyAddressOrCard.localizedDescription)
        }
    }
}

extension CompleteOrderPresenter: CompleteOrderInteractorOutputs {
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func alert(title: String, message: String) {
        view?.presentAlert(title: title, message: message)
    }
    
    func orderSuccess() {
        router?.toHome()
    }
}
