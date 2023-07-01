//
//  UserProfileViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func prepareTableView()
}

final class ProfileViewController: UIViewController {
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 200
        return tableView
    }()
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    internal var presenter: ProfilePresenterInputs!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

// MARK: - Profile View Protocol
extension ProfileViewController: ProfileViewProtocol {
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func prepareTableView() {
        view.addSubview(profileTableView)
        
        profileTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Profile TableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }
}
