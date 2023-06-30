//
//  ProductDetailViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    func setNavBarAndTabBarVisibility()
    func setBackgroundColor(color: UIColor)
    func prepareCollectionView()
    func prepareActivtyIndicatorView()
    func prepareAddBasketView()
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(message: String)
    func setBasketViewPriceLabel(price: String)
}

final class ProductDetailViewController: UIViewController {
    
    private lazy var detailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductDetailCell.self, forCellWithReuseIdentifier: ProductDetailCell.identifier)
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    private lazy var customAddBasketView = AddBasketView()
    
    internal var presenter: ProductDetailPresenterInputs!
    
// MARK: - Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillApper()
    }
}

// MARK: - Product Detail View Protoc
extension ProductDetailViewController: ProductDetailViewProtocol {
    func setBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func setNavBarAndTabBarVisibility() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func prepareAddBasketView() {
        view.addSubview(customAddBasketView)
        customAddBasketView.layer.shadowOpacity = 1
        customAddBasketView.delegate = self
        
        customAddBasketView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(view.frame.width)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func prepareCollectionView() {
        view.addSubview(detailCollectionView)
        
        detailCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(customAddBasketView.snp.top)
        }
    }
    
    func prepareActivtyIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func endLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    func dataRefreshed() {
        detailCollectionView.reloadData()
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
        
    func setBasketViewPriceLabel(price: String) {
        customAddBasketView.priceLabel.text = price
    }
}

extension ProductDetailViewController: ProductDetailCellButtonsDelegate {
    func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func favButtonTapped() {
        presenter.favButtonTapped()
    }
}

extension ProductDetailViewController: AddBasketButtonDelegate {
    func addBasketTapped() {
        
    }
}

// MARK: - Detail Collection View Delegates & DataSource
extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCell.identifier, for: indexPath) as? ProductDetailCell else { return UICollectionViewCell()}
        cell.showModel(model: presenter.showModel(), isFav: presenter.isFav())
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt()
    }
}
