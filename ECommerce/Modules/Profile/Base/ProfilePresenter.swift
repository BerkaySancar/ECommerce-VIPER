//
//  UserProfilePresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation

protocol ProfilePresenterInputs {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> ProfileRowItemModel?
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    func didSelectRowAt(indexPath: IndexPath)
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

// MARK: - Presenter Inputs
extension ProfilePresenter: ProfilePresenterInputs {
    func viewDidLoad() {
        view?.setNavTitle(title: "My Profile")
        view?.setBackgroundColor()
        view?.prepareUserInfoView()
        view?.prepareTableView()
        interactor?.getUserInfos()
    }
    
    func numberOfRowsInSection() -> Int {
        return interactor?.showItems().count ?? 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> ProfileRowItemModel? {
        return interactor?.showItems()[indexPath.row]
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItem = interactor?.showItems()[indexPath.row]
        
        switch selectedItem?.item {
        case .address:
            router?.toAddresses()
        case .payment:
            router?.toPaymentInfo()
        case .orderHistory:
            router?.toOrderHistory()
        case .signOut:
            interactor?.signOutAction()
        default:
            break
        }
    }
}

// MARK: - Interactor to Presenter
extension ProfilePresenter: ProfileInteractorOutputs {
     
    func showUserInfo(model: CurrentUserModel?) {
        view?.showCurrentUserInfo(model: model)
    }
    
    func startLoading() {
        view?.startLoading()
    }
    
    func endLoading() {
        view?.endLoading()
    }
    
    func signOutCompleted() {
        router?.toLogin()
    }
    
    func onError(message: String) {
        view?.onError(message: message)
    }
}
