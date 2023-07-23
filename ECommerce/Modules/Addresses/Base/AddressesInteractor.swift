//
//  AddressesInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import Foundation

protocol AddressesInteractorInputs {
    func getAddresses()
    func showAddresses() -> [AddressModel]?
    func addAction(model: [String: Any])
    func updateAction(model: [String: Any])
    func deleteAction(model: AddressModel?)
}

protocol AddressesInteractorOutputs: AnyObject {
    func dataRefreshed()
    func onError(error: RealmError)
}

final class AddressesInteractor {
    weak var presenter: AddressesInteractorOutputs?
    private let storageManager: RealmManagerProtocol?
    private let userInfoManager: UserInfoManagerProtocol?
    
    private var addresses: [AddressModel]? {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    init(storageManager: RealmManagerProtocol?, userInfoManager: UserInfoManagerProtocol) {
        self.storageManager = storageManager
        self.userInfoManager = userInfoManager
    }
}

// MARK: Interactor Inputs
extension AddressesInteractor: AddressesInteractorInputs {
    
    func getAddresses() {
        self.addresses = storageManager?.getAll(AddressModel.self).filter { $0.userId == userInfoManager?.getUserUid() }
    }
    
    func showAddresses() -> [AddressModel]? {
        return self.addresses
    }
    
    func addAction(model: [String: Any]) {
        let address = AddressModel(userId: (model["userId"] as! String),
                                   uuid: (model["uuid"] as! UUID),
                                   name: model["name"] as! String,
                                   country: model["country"] as! String,
                                   city: model["city"] as! String,
                                   street: model["street"] as! String,
                                   buildingNumber: model["buildingNumber"] as! Int,
                                   zipCode: model["zipCode"] as! Int)
        storageManager?.create(address, onError: { [weak self] error in
            guard let self else { return }
            presenter?.onError(error: error)
        })
        presenter?.dataRefreshed()
    }
    
    func updateAction(model: [String: Any]) {
        guard let savedAddress = self.addresses?.filter({ $0.uuid == (model["uuid"] as! UUID) }).first else { return }
        
        storageManager?.update(savedAddress, with: model, onError: { [weak self] error in
            guard let self else { return }
            self.presenter?.onError(error: error)
        })
        self.presenter?.dataRefreshed()
    }
    
    func deleteAction(model: AddressModel?) {
        if let model {
            if let index = self.addresses?.firstIndex(where: { $0.uuid == model.uuid }) {
                storageManager?.delete(model, onError: { [weak self] error in
                    guard let self else { return }
                    self.presenter?.onError(error: error)
                })
                self.addresses?.remove(at: index)
            }
        }
    }
}
