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
}

final class CompleteOrderPresenter {
    private weak var view: CompleteOrderViewProtocol?
    private let interactor: CompleteOrderInteractorInputs?
    private let router: CompleteOrderRouterProtocol?
    
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
    
    func completeButtonTapped() {
        
    }
}

extension CompleteOrderPresenter: CompleteOrderInteractorOutputs {
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
}
