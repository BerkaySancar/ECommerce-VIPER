//
//  TotalPriceCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

final class TotalPriceCell: UICollectionViewCell {
    
    static let identifier = "TotalPriceCell"
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "Delivery"
        return label
    }()
    
    private lazy var basketLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "Basket"
        return label
    }()
    
    private lazy var deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private lazy var basketPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.text = "Total"
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(deliveryLabel)
        addSubview(basketLabel)
        addSubview(deliveryPriceLabel)
        addSubview(basketPriceLabel)
        addSubview(totalLabel)
        addSubview(totalPriceLabel)
        
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryLabel)
            make.right.equalToSuperview().inset(16)
        }
        
        basketLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(8)
            make.left.equalTo(deliveryLabel)
        }
        
        basketPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(basketLabel)
            make.right.equalTo(deliveryPriceLabel)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(basketLabel.snp.bottom).offset(8)
            make.left.equalTo(basketLabel)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(totalLabel)
            make.right.equalTo(basketPriceLabel)
        }
    }
    
    func showModel(model: (price: Double, delivery: Double)?) {
        if let model {
            let formattedPrice = String(format: "%.2f", model.price)
            let formattedDelivery = String(format: "%.2f", model.delivery)
            self.basketPriceLabel.text = "$" + formattedPrice
            self.deliveryPriceLabel.text = "$" + formattedDelivery
            let total = model.price + model.delivery
            let formattedTotal = "$" + String(format: "%.2f", total)
            self.totalPriceLabel.text = formattedTotal
        }
    }
}
