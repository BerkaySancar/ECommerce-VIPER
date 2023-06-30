//
//  HomePresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

protocol HomePresenterInputs {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfSection() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func cellForItemAt(indexPath: IndexPath) -> ProductModel?
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func showProducts() -> [ProductModel]?
    func showCategories() -> Categories?
    func searchTextDidChange(text: String?)
    func categorySelected(category: String)
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
    
    func viewWillAppear() {
        view?.setNavBarAndTabBarVisibility()
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
    
    func didSelectItemAt(indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let id = interactor?.showProducts()[indexPath.item].id {
                router?.toDetail(id: id)
            }
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
    
    func categorySelected(category: String) {
        interactor?.getCategoryProducts(category: category)
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
    
    func showProfileImageAndEmail(model: NavBarViewModel) {
        view?.setProfileImageAndUserEmail(model: model)
    }
}
