//
//  BasketCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 3.07.2023.
//

import UIKit
import SDWebImage

protocol BasketCellStepperCountDelegate: AnyObject {
    func stepperValueChanged(value: Double, item: BasketModel?)
}

final class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var productCountLabel: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 4, 4)
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.layer.cornerRadius = 8
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.value = 1
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
    
    private var model: BasketModel?
    weak var delegate: BasketCellStepperCountDelegate?
    
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
        }

        productCountLabel.snp.makeConstraints { make in
            make.width.equalTo(94)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        stepper.snp.makeConstraints { make in
            make.centerX.equalTo(productCountLabel.snp.centerX)
        }
        
        hStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func stepperValueChanged() {
        delegate?.stepperValueChanged(value: stepper.value, item: self.model)
    }
    
    func showModel(model: BasketModel?) {
        self.model = model
        
        if let model {
            stepper.value = Double(model.count)
            productTitleLabel.text = model.productTitle
            let price =  model.productPrice * Double(model.count)
            let formattedPrice = String(format: "%.2f", price)
            productPriceLabel.text = "$ \(formattedPrice)"
            productImageView.sd_setImage(with: URL(string: model.imageURL))
            productCountLabel.text = String(model.count)
        }
    }
}
