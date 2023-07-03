//
//  BasketCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import UIKit

final class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.text = "BMW e36 m3 s52b32asdasdas"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.text = "$300"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var productCountLabel: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 4, 4)
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.layer.cornerRadius = 8
        label.font = .systemFont(ofSize: 20)
        label.text = "1"
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.stepValue = 1
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productImageView,
                                                       VerticalStackView(arrangedSubviews: [productTitleLabel, productPriceLabel],
                                                                         spacing: 28),
                                                       VerticalStackView(arrangedSubviews: [productCountLabel, stepper],
                                                                         spacing: 4)])
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContstraints() {
        contentView.addSubview(hStackView)
        
        productImageView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.width.equalTo(90)
            productImageView.image = .init(named: "onboarding1")
        }
        
        productCountLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func stepperValueChanged() {
        productCountLabel.text = "\(Int(stepper.value))"
    }
}
