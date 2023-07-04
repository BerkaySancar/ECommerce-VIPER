//
//  BasketViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import UIKit

protocol BasketViewProtocol: AnyObject {
    func setNavTitle(title: String)
    func prepareBasketTableView()
    func prepareActivtyIndicatorView()
    func startLoading()
    func endLoading()
    func dataRefreshed()
    func onError(message: String)
}

class BasketViewController: UIViewController {
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        return tableView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.tintColor = .label
        return aiv
    }()
    
    internal var presenter: BasketPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension BasketViewController: BasketViewProtocol {

    func setNavTitle(title: String) {
        self.title = title
    }
    
    func prepareBasketTableView() {
        view.addSubview(basketTableView)
        
        basketTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        basketTableView.reloadData()
    }
    
    func onError(message: String) {
        showAlert(title: "", message: message)
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as? BasketCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.showModel(model: presenter.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt(indexPath: indexPath)
    }
}
