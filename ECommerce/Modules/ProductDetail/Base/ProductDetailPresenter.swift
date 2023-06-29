//
//  ProductDetailPresenter.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import Foundation

protocol ProductDetailPresenterInputs {
    func viewDidLoad()
    func viewWillApper()
    func showModel() -> ProductModel?
    func numberOfItemsInSection() -> Int
    func sizeForItemAt() -> CGSize
}

final class ProductDetailPresenter {
    private weak var view: ProductDetailViewProtocol?
    private let interactor: ProductDetailInteractorInputs?
    private let router: ProductDetailRouterProtocol?
    
    private var productModel: ProductModel? {
        didSet {
            view?.setBasketViewPriceLabel(price: String(productModel?.price ?? 0))
            dataRefreshed()
        }
    }
    
    init(view: ProductDetailViewProtocol, interactor: ProductDetailInteractorInputs, router: ProductDetailRouterProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension ProductDetailPresenter: ProductDetailPresenterInputs {
    func viewDidLoad() {
        view?.setNavigationTitle(title: "Detail")
        view?.setBackgroundColor(color: .systemBackground)
        view?.prepareAddBasketView()
        view?.prepareCollectionView()
        view?.prepareActivtyIndicatorView()
        interactor?.getProduct()
    }
    
    func viewWillApper() {
        
    }
    
    func showModel() -> ProductModel? {
        return self.productModel
    }
    
    func numberOfItemsInSection() -> Int {
        return 1
    }
    
    func sizeForItemAt() -> CGSize {
        return .init(width: UIScreenBounds.width - 32, height: UIScreenBounds.height)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputs {
   
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
    
    func showModel(model: ProductModel?) {
        self.productModel = model
    }
}
