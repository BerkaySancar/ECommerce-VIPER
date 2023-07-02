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
    func setNavBarAndTabBarVisibility()
    func prepareSearchBar()
    func prepareHomeCollectionView()
    func prepareActivtyIndicatorView()
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(message: String)
    func setProfileImageAndUserEmail(model: CurrentUserModel)
}

final class HomeViewController: UIViewController {
    
    private lazy var customNavBarView = CustomNavBarView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search anything"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
}

// MARK: - HomeView Protocols
extension HomeViewController: HomeViewProtocol {
    
    func setViewBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func prepareNavBarView() {
        self.navigationController?.navigationBar.addSubview(customNavBarView)
    }
    
    func setNavBarAndTabBarVisibility() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func prepareSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.left.right.equalToSuperview().inset(8)
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
    
    func setProfileImageAndUserEmail(model: CurrentUserModel) {
        customNavBarView.showModel(model: model)
    }
}

// MARK: - Search bar delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChange(text: searchText)
    }
}

// MARK: - Category button delegate
extension HomeViewController: CategoryTitleCellButtonDelegete {
    func titleTapped(selectedTitle: String) {
        presenter.categorySelected(category: selectedTitle)
    }
}

// MARK: - Product cell button delegate
extension HomeViewController: ProductCellButtonDelegate {
    func favTapped(model: ProductModel?) {
        presenter.favTapped(model: model)
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
            cell.delegate = self
            return cell
        } else {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            cell.showModel(model: presenter.showProducts()?[indexPath.item], isFav: presenter.isFav(indexPath: indexPath))
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItemAt(indexPath: indexPath)
    }
}
