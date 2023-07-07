//
//  OrderCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 7.07.2023.
//

import UIKit

final class OrderCell: UITableViewCell {
    
    static let identifier = "OrderCell"

    private lazy var orderDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var productsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var vStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [orderDateLabel, productsLabel, totalPriceLabel], spacing: 16)
        stackView.alignment = .center
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func showModel(order: OrderModel) {
        let timestamp: TimeInterval = 1678805970
        let date = Date(timeIntervalSince1970: timestamp)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"

        let dateString = dateFormatter.string(from: date)
        
        orderDateLabel.text = dateString
        let formattedPrice = String(format: "%.2f", order.total)
        totalPriceLabel.text = "TOTAL: $" + formattedPrice
        
        var productsText = ""
        for (key, value) in order.products {
            productsText += "🛍️" + key + " ⎯ \(value)" + "\n"
        }
        productsLabel.text = productsText
    }
}
