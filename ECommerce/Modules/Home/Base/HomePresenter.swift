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
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func didSelectItemAt(indexPath: IndexPath)
    func showProducts() -> [ProductModel]?
    func showCategories() -> Categories?
    func searchTextDidChange(text: String?)
    func categorySelected(category: String)
    func favTapped(model: ProductModel?)
    func isFav(indexPath: IndexPath) -> Bool?
}

enum HomeViewCellType: CaseIterable {
    case categories
    case products
    
    static func numberOfSection() -> Int {
        return self.allCases.count
    }
    
    static func getSection(section: Int) -> HomeViewCellType {
        return self.allCases[section]
    }
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
        interactor?.getFavorites()
    }
    
    func numberOfSection() -> Int {
        return HomeViewCellType.numberOfSection()
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        switch HomeViewCellType.getSection(section: section) {
        case .categories:
            return interactor?.showCategories().count ?? 0
        case .products:
            return interactor?.showProducts().count ?? 0
        }
    }

    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch HomeViewCellType.getSection(section: indexPath.section) {
        case .categories:
            let title = interactor?.showCategories()[indexPath.item].capitalized
            let width = title?.width(withConstrainedHeight: 50, font: .systemFont(ofSize: 22))
            return CGSize(width: width!, height: 40)
        case .products:
            return .init(width: UIScreenBounds.width / 2.3, height: 300)
        }
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        switch HomeViewCellType.getSection(section: indexPath.section) {
        case .categories:
            break
        case .products:
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
    
    func isFav(indexPath: IndexPath) -> Bool? {
        return interactor?.isFav(model: interactor?.showProducts()[indexPath.item])
    }
    
    func favTapped(model: ProductModel?) {
        interactor?.favAction(model: model)
    }
}

// MARK: - Home Interactor to Presenter
extension HomePresenter: HomeInteractorOutputs {
    
    func startLoading() {
        view?.startLoading()
    }
    
    func endLoading() {
        view?.endLoading()
    }
    
    func dataRefreshed() {
        view?.dataRefreshed()
    }
    
    func onError(errorMessage: String) {
        view?.onError(message: errorMessage)
    }
    
    func showProfileImageAndEmail(model: CurrentUserModel) {
        view?.setProfileImageAndUserEmail(model: model)
    }
}
