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
        view?.prepareBasketTableView()
        view?.prepareActivtyIndicatorView()
        interactor?.getItems()
    }
    
    func viewWillAppear() {
//        interactor?.getItems()
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
}
