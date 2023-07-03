//
//  BasketPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import Foundation

protocol BasketPresenterInputs {
   func viewDidLoad()
   func numberOfRowsInSection(section: Int)
   func cellForRowAt(indexPath: IndexPath)
   func heightForRowAt(indexPath: IndexPath) -> CGFloat
   
 
    
}

final class BasketPresenter {
    private weak var view: BasketViewProtocol?
    private let interactor: BasketInteractorInputs?
    private let router: BasketRouterProtocol?
    
    init(view: BasketViewProtocol, interactor: BasketInteractorInputs, router: BasketRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension BasketPresenter: BasketPresenterInputs {
  
    func viewDidLoad() {
        view?.setNavTitle(title: "My Basket")
        view?.prepareBasketTableView()
    }
    
    func numberOfRowsInSection(section: Int) {
        
    }
    
    func cellForRowAt(indexPath: IndexPath) {
        
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    
    
}

extension BasketPresenter: BasketInteractorOutputs {
    
}
