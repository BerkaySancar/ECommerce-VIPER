//
//  UserProfileInteractor.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation


protocol ProfileInteractorInputs {
    func getUserInfos()
    func showItems() -> [ProfileRowItemModel]
    func signOutAction()
}

protocol ProfileInteractorOutputs: AnyObject {
    func showUserInfo(model: CurrentUserModel?)
    func startLoading()
    func endLoading()
    func signOutCompleted()
    func onError(message: String)
}

final class ProfileInteractor {
    weak var presenter: ProfileInteractorOutputs?
    private let userInfoManager: UserInfoManagerProtocol?
    private let authManager: AuthManagerProtocol?
    
    private let rowItems: [ProfileRowItemModel] = [
        .init(item: .address),
        .init(item: .payment),
        .init(item: .orderHistory),
        .init(item: .signOut)
    ]
    
    init(userInfoManager: UserInfoManagerProtocol, authManager: AuthManagerProtocol) {
        self.userInfoManager = userInfoManager
        self.authManager = authManager
    }
}

//MARK: - Interactor Inputs
extension ProfileInteractor: ProfileInteractorInputs {
    
    func getUserInfos() {
        userInfoManager?.getUserProfilePictureAndEmail(completion: { [weak self] photo, email in
            guard let self else { return }
            let model: CurrentUserModel = .init(profileImageURLString: photo, userEmail: email)
            presenter?.showUserInfo(model: model)
        })
    }
    
    func showItems() -> [ProfileRowItemModel] {
        return self.rowItems
    }
    
    func signOutAction() {
        presenter?.startLoading()
        authManager?.signOut { [weak self] result in
            guard let self else { return }
            presenter?.endLoading()
            
            switch result {
            case .success(_):
                presenter?.signOutCompleted()
            case .failure(let error):
                presenter?.onError(message: error.localizedDescription)
            }
        }
    }
}
