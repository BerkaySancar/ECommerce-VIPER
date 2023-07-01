//
//  UserProfilePresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation

protocol ProfilePresenterInputs {
    func viewDidLoad()
}

final class ProfilePresenter {
    private weak var view: ProfileViewProtocol?
    private let interactor: ProfileInteractorInputs?
    private let router: ProfileRouterProtocol?
    
    init(view: ProfileViewProtocol, interactor: ProfileInteractorInputs, router: ProfileRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ProfilePresenter: ProfilePresenterInputs {
    func viewDidLoad() {
        view?.setNavTitle(title: "My Profile")
        view?.prepareTableView()
    }
}

extension ProfilePresenter: ProfileInteractorOutputs {
    
}
