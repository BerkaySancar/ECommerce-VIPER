//
//  AddressesPresneter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation

protocol AddressesPresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
    func numberOfItemsInSection(section: Int)  -> Int
    func cellForItemAt(indexPath: IndexPath) -> AddressModel?
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func toAddButtonTapped()
}

final class AddressesPresenter {
    private weak var view: AddressesViewProtocol?
    private let interactor: AddressesInteractorInputs?
    private let router: AddressesRouterProtocol?
    
    init(view: AddressesViewProtocol, interactor: AddressesInteractorInputs, router: AddressesRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .addUpdateButtonNotification, object: nil)
    }
}

extension AddressesPresenter: AddressesPresenterInputs {
    
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .systemBackground)
        view?.setNavBarTitle(title: "My Addresses")
        view?.prepareCollectionView()
        view?.prepareEmptyView()
        interactor?.getAddresses()
    }
    
    func viewWillAppear() {
        interactor?.getAddresses()
    }
    
    func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self, name: .addUpdateButtonNotification, object: nil)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return interactor?.showAddresses()?.count ?? 0
    }
    
    func cellForItemAt(indexPath: IndexPath) -> AddressModel? {
        return interactor?.showAddresses()?[indexPath.item]
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreenBounds.width - 32, height: 180)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        
    }
    
    func toAddButtonTapped() {
        router?.toAddAddress()
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let address = notification.userInfo?["address"] else { return }
        guard let action = notification.userInfo?["action"] else { return }
        
        if action as! String == "add" {
            interactor?.addAction(model: address as! AddressModel)
        } else {
            interactor?.updateAction(model: address as! AddressModel)
        }
    }
}

extension AddressesPresenter: AddressesInteractorOutputs {
 
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func onError(error: RealmError) {
        view?.onError(message: error.localizedDescription)
    }
    
}
