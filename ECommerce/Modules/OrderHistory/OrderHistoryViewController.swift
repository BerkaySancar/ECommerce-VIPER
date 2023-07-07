//
//  OrderHistoryViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 7.07.2023.
//

import UIKit
import FirebaseFirestore

final class OrderHistoryViewController: UIViewController {
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: OrderCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private var orders: [OrderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Order History"
        setupConstraints()
        getOrders()
    }
    
    private func setupConstraints() {
        view.addSubview(ordersTableView)
        
        ordersTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func getOrders() {
        if let userId = UserInfoManager.shared.getUserUid() {
            Firestore.firestore().collection("Orders").whereField("userId", isEqualTo: userId).addSnapshotListener { [weak self] snapshot, error in
                guard let self else { return }
                
                if let error {
                    showAlert(title: "", message: error.localizedDescription)
                    return
                } else {
                    guard let documents = snapshot?.documents else { return }
                    self.orders = []
                    for document in documents {
                        if let date = document.get("date") as? Timestamp,
                           let products = document.get("products") as? [String: Int],
                           let total = document.get("total") as? Double
                        {
                            let order = OrderModel(date: date, products: products, total: total)
                            self.orders.append(order)
                            self.ordersTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension OrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ordersTableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath) as? OrderCell else { return UITableViewCell() }
        cell.showModel(order: self.orders[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

struct OrderModel {
    let date: Timestamp
    let products: [String: Int]
    let total: Double
}

