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
}

class BasketViewController: UIViewController {
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        return tableView
    }()
    
    internal var presenter: BasketPresenterInputs!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
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
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: BasketCell.identifier, for: indexPath) as? BasketCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt(indexPath: indexPath)
    }
}
