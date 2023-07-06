//
//  BasketBottomView.swift
//  ECommerce
//
//  Created by Berkay Sancar on 4.07.2023.
//

import UIKit

protocol BasketBottomViewButtonDelegate: AnyObject {
    func continueShoppingTapped()
    func completePaymentTapped()
}

final class BasketBottomView: UIView {
    
    private lazy var totalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        label.text = "Total Price Payable"
        return label
    }()
    
    private lazy var totalDollarLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var continueShoppingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue Shopping", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(continueShoppingTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var completePaymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Complete the Payment", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(completePaymentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [totalPriceTitleLabel,
                                                             totalDollarLabel,
                                                             continueShoppingButton,
                                                             completePaymentButton], spacing: 4)
        stackView.alignment = .leading
        return stackView
    }()
    
    weak var delegate: BasketBottomViewButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(vStackView)
        
        continueShoppingButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        completePaymentButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func continueShoppingTapped() {
        delegate?.continueShoppingTapped()
    }
    
    @objc
    private func completePaymentTapped() {
        delegate?.completePaymentTapped()
    }
    
    func fixTotalPrice(price: Double) {
        let formattedPrice = String(format: "%.2f", price)
        totalDollarLabel.text = price != 0 ? "$\(formattedPrice)" : "0"
    }
}
