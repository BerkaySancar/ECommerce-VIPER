//
//  FavoritesViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func setNavBarAndTabBarVisibility()
    func prepareTrashBarButton()
    func prepareTableView()
    func dataRefreshed()
    func onError(message: String)
    func presentTrashAllAlert()
}

final class FavoritesViewController: UIViewController {
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        return tableView
    }()
    
    private lazy var jumpToHomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("List is clear. Tap to see the products.", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(jumpToHomeTapped), for: .touchUpInside)
        return button
    }()
    
    internal var presenter: FavoritesPresenterInputs!

// MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    @objc
    private func trashButtonTapped() {
        presenter.trashButtonTapped()
    }
    
    @objc
    private func jumpToHomeTapped() {
        presenter.jumpToHomeTapped()
    }
}

// MARK: - Favorites View Protocol
extension FavoritesViewController: FavoritesViewProtocol {
    
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func setNavBarAndTabBarVisibility() {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func prepareTrashBarButton() {
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    func prepareTableView() {
        view.addSubview(favoritesTableView)
        favoritesTableView.backgroundView = jumpToHomeButton
        
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
  
    func dataRefreshed() {
        favoritesTableView.reloadData()
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
    
    func presentTrashAllAlert() {
        deleteAllSheetAlert { [weak self] in
            guard let self else { return }
            self.presenter.deleteAllFavorites()
        }
    }
}

// MARK: - Favorites Table View Delegates & DataSources
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jumpToHomeButton.isHidden = tableView.visibleCells.isEmpty ? false : true
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.showModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRowAt()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteItemForRowAt(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
