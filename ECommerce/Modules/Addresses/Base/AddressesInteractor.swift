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
    func addAction(model: AddressModel)
    func updateAction(model: AddressModel)
}

protocol AddressesInteractorOutputs: AnyObject {
    func dataRefreshed()
    func onError(error: RealmError)
}

final class AddressesInteractor {
    weak var presenter: AddressesInteractorOutputs?
    private let storageManager: RealmManagerProtocol?
    
    private var addresses: [AddressModel]? {
        didSet {
            presenter?.dataRefreshed()
        }
    }
    
    init(storageManager: RealmManagerProtocol?) {
        self.storageManager = storageManager
    }
}

// MARK: Interactor Inputs
extension AddressesInteractor: AddressesInteractorInputs {
    
    func getAddresses() {
        self.addresses = storageManager?.getAll(AddressModel.self)
    }
    
    func showAddresses() -> [AddressModel]? {
        return self.addresses
    }
    
    func addAction(model: AddressModel) {
        storageManager?.create(model, onError: { [weak self] error in
            guard let self else { return }
            presenter?.onError(error: error)
        })
        presenter?.dataRefreshed()
        print("in")
    }
    
    func updateAction(model: AddressModel) {
        guard let savedAddress = self.addresses?.filter({ $0.uuid == model.uuid }).first else { return }
        let dict: [String:Any] = [
            "userId:": "\(String(describing: model.userId))",
            "uuid": "\(String(describing: model.uuid))",
            "name": "\(String(describing: model.name))",
            "country": "\(String(describing: model.country))",
            "city": "\(String(describing: model.city))",
            "street:": "\(String(describing: model.street))",
            "buildingNumber": model.buildingNumber,
            "zipCode": model.zipCode
        ]
        
        storageManager?.update(savedAddress, with: dict, onError: { [weak self] error in
            guard let self else { return }
            self.presenter?.onError(error: error)
        })
        self.presenter?.dataRefreshed()
    }
}
