//
//  FavoritesViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func prepareTrashBarButton()
    func prepareTableView()
}

final class FavoritesViewController: UIViewController {
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        return tableView
    }()
    
    internal var presenter: FavoritesPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    @objc
    private func trashButtonTapped() {
        print("tapped")
    }
}

// MARK: - Favorites View Protocol
extension FavoritesViewController: FavoritesViewProtocol {
    
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func prepareTrashBarButton() {
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .trash, target: self, action: #selector(trashButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    func prepareTableView() {
        view.addSubview(favoritesTableView)
        
        favoritesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Favorites Table View Delegates & DataSources
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        cell.showModel()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRowAt()
    }
}
