//
//  UserProfileViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func setBackgroundColor()
    func prepareUserInfoView()
    func prepareTableView()
    func startLoading()
    func endLoading()
    func onError(message: String)
    func showCurrentUserInfo(model: CurrentUserModel?)
}

final class ProfileViewController: UIViewController {
    
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        return tableView
    }()
    
    private lazy var userInfoView = UserInfoView()
    
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
    
    func setBackgroundColor() {
        self.view.backgroundColor = .systemBackground
    }
    
    func prepareUserInfoView() {
        view.addSubview(userInfoView)
        
        userInfoView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(280)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func prepareTableView() {
        view.addSubview(profileTableView)
        
        profileTableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func startLoading() {
            
    }
    
    func endLoading() {
        
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
    
    
    func showCurrentUserInfo(model: CurrentUserModel?) {
        userInfoView.showModel(model: model)
    }
}

// MARK: - Profile TableView Delegate & DataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = profileTableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier, for: indexPath) as? ProfileCell
        else { return UITableViewCell() }
        cell.showModel(model: presenter.cellForRowAt(indexPath: indexPath))
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
