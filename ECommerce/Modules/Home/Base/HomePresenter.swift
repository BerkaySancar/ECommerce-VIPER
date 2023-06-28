//
//  HomePresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation

protocol HomePresenterInputs {
    func viewDidLoad()
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
        view?.prepareHomeCollectionView()
    }
}

extension HomePresenter: HomeInteractorOutputs {
    
}
