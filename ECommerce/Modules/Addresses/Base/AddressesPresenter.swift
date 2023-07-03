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
    func numberOfItemsInSection(section: Int)  -> Int
    func cellForItemAt(indexPath: IndexPath) -> AddressModel?
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func toAddButtonTapped()
    func trashTapped(model: AddressModel?)
}

final class AddressesPresenter {
    private weak var view: AddressesViewProtocol?
    private let interactor: AddressesInteractorInputs?
    private let router: AddressesRouterProtocol?
    
    init(view: AddressesViewProtocol, interactor: AddressesInteractorInputs, router: AddressesRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.notificationReceived(_:)),
                                               name: .addUpdateButtonNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .addUpdateButtonNotification, object: nil)
    }
}

extension AddressesPresenter: AddressesPresenterInputs {
    
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .systemBackground)
        view?.setNavBarTitle(title: "My Addresses")
        view?.prepareCollectionView()
        view?.prepareEmptyView()
    }
    
    func viewWillAppear() {
        interactor?.getAddresses()
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
        let selectedAddress = interactor?.showAddresses()?[indexPath.item]
        router?.toAddAddress(address: selectedAddress)
    }
    
    func toAddButtonTapped() {
        router?.toAddAddress(address: nil)
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let newInfos = notification.userInfo?["address"] else { return }
        guard let action = notification.userInfo?["action"] else { return }
        
        if action as! String == "add" {
            interactor?.addAction(model: newInfos as! [String: Any])
        } else {
            interactor?.updateAction(model: newInfos as! [String: Any])
        }
    }
    
    func trashTapped(model: AddressModel?) {
        interactor?.deleteAction(model: model)
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
