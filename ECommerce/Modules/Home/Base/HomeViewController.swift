//
//  HomeViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func setViewBackgroundColor(color: UIColor)
    func prepareNavBarView()
    func prepareSearchBar()
    func prepareHomeCollectionView()
    func prepareActivtyIndicatorView()
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(message: String)
}

final class HomeViewController: UIViewController {
    
    private lazy var navBarView = CustomNavBarView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search anything"
        searchBar.searchBarStyle = .prominent
        return searchBar
    }()
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryTitleCell.self, forCellWithReuseIdentifier: CategoryTitleCell.identifier)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    internal var presenter: HomePresenterInputs!
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - HomeView protocols
extension HomeViewController: HomeViewProtocol {

    func setViewBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func prepareNavBarView() {
        navigationController?.navigationBar.addSubview(navBarView)
    }
    
    func prepareSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.right.equalToSuperview()
        }
    }
   
    func prepareHomeCollectionView() {
        view.addSubview(homeCollectionView)
        
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
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
        homeCollectionView.reloadData()
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
}

// MARK: - Collection View Delegates
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryTitleCell.identifier, for: indexPath) as? CategoryTitleCell else { return UICollectionViewCell() }
            cell.setTitle(title: presenter.showCategories()?[indexPath.item])
            return cell
        } else {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            cell.showModel(model: presenter.showProducts()?[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 0, right: 16)
    }
}

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

