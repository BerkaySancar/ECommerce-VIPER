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
    func cellForItemAt(indexPath: IndexPath) -> String
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
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

extension HomePresenter: HomePresenterInputs {
    func viewDidLoad() {
        view?.setViewBackgroundColor(color: .systemBackground)
        view?.prepareSearchBar()
        view?.prepareNavBarView()
        view?.prepareHomeCollectionView()
    }
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 10
        }
    }
    
    func cellForItemAt(indexPath: IndexPath) -> String {
        return "berkay"
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let arr = ["Electronics", "Jewelery", "Men's clothing", "Women's clothing"]
            let title = arr[indexPath.item]
            let width = title.width(withConstrainedHeight: 50, font: .systemFont(ofSize: 22))
            return CGSize(width: width, height: 50)
        } else {
            return .init(width: UIScreenBounds.width, height: 200)
        }
    }
}

extension HomePresenter: HomeInteractorOutputs {
    
}
