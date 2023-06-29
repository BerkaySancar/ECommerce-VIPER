//
//  HomePresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

protocol HomePresenterInputs {
    func viewDidLoad()
    func numberOfSection() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) -> ProductModel?
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func showProducts() -> [ProductModel]?
    func showCategories() -> Categories?
    func searchTextDidChange(text: String?)
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    private let interactor: HomeInteractorInputs?
    private let router: HomeRouterProtocol?
    
    init(view: HomeViewProtocol, interactor: HomeInteractorInputs, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Home Presenter Inputs
extension HomePresenter: HomePresenterInputs {
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .systemBackground)
        view?.prepareSearchBar()
        view?.prepareNavBarView()
        view?.prepareHomeCollectionView()
        view?.prepareActivtyIndicatorView()
        interactor?.getData()
        interactor?.getUserProfilePictureAndEmail()
    }
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return interactor?.showCategories().count ?? 0
        } else {
            return interactor?.showProducts().count ?? 0
        }
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ProductModel? {
        return interactor?.showProducts()[indexPath.row]
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let title = interactor?.showCategories()[indexPath.item].capitalized
            let width = title?.width(withConstrainedHeight: 50, font: .systemFont(ofSize: 22))
            return CGSize(width: width!, height: 40)
        } else {
            return .init(width: UIScreenBounds.width / 2.3, height: 300)
        }
    }
    
    func showProducts() -> [ProductModel]? {
        return interactor?.showProducts()
    }
    
    func showCategories() -> Categories? {
        return interactor?.showCategories().map { $0.capitalized }
    }
    
    func searchTextDidChange(text: String?) {
        if let text {
            interactor?.searchTextDidChange(text: text)
        }
    }
}

// MARK: - Home Interactor to Presenter
extension HomePresenter: HomeInteractorOutputs {
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.startLoading()
        }
    }
    
    func endLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.endLoading()
        }
    }
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func onError(error: NetworkError) {
        view?.onError(message: error.localizedDescription)
    }
    
    func showProfileImage(imageURLString: String?, email: String?) {
        view?.setProfileImage(urlString: imageURLString, email: email)
    }
}
