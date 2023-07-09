//
//  BasketPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import Foundation

protocol BasketPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(indexPath: IndexPath) -> BasketModel?
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func continueShoppingTapped()
    func completePaymentTapped()
    func stepperValueChanged(value: Double, item: BasketModel?)
}

final class BasketPresenter {
    private weak var view: BasketViewProtocol?
    private let interactor: BasketInteractorInputs?
    private let router: BasketRouterProtocol?
    
    init(view: BasketViewProtocol, interactor: BasketInteractorInputs, router: BasketRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterInputs {
  
    func viewDidLoad() {
        view?.setNavTitle(title: "My Basket")
        view?.setBackgroundColor(color: .systemBackground)
        view?.prepareCustomBottomView()
        view?.prepareBasketTableView()
        view?.prepareEmptyBasketView()
        view?.prepareActivtyIndicatorView()
        interactor?.getItems()
    }
    
    func viewWillAppear() {
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor?.showItems()?.count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> BasketModel? {
        return interactor?.showItems()?[indexPath.row]
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func continueShoppingTapped() {
        router?.toHome()
    }
    
    func completePaymentTapped() {
        let items = interactor?.showItems()
        if items?.count == 0 {
            view?.onError(message: GeneralError.emptyBasketError.localizedDescription)
        } else {
            router?.toCompleteOrder(items: items)
        }
    }
    
    func stepperValueChanged(value: Double, item: BasketModel?) {
        interactor?.updateItem(value: value, item: item)
    }
}

extension BasketPresenter: BasketInteractorOutputs {
   
    func onError(message: String) {
        view?.onError(message: message)
    }
    
    func startLoading() {
        view?.startLoading()
    }
    
    func endLoading() {
        view?.endLoading()
    }
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func showTotal(price: Double) {
        view?.calculateTotalPrice(price: price)
    }
}
