//
//  ProductDetailCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 29.06.2023.
//

import UIKit
import SDWebImage

final class ProductDetailCell: UICollectionViewCell {
    
    static let identifier = "ProductDetailCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productFavButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.layer.cornerRadius = 8
        button.setImage(UIImage(systemName: "heart",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44)),
                        for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "heart.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44)),
                        for: UIControl.State.selected)
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
 
    private lazy var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var productRatingAndCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var productCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var customSpacerView: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return view
    }()

    private lazy var vStackView = VerticalStackView(arrangedSubviews: [productImageView,
                                                                       productTitleLabel,
                                                                       productRatingAndCountLabel,
                                                                       productDescriptionLabel,
                                                                       customSpacerView],
                                                    spacing: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpConstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(vStackView)
        contentView.addSubview(productFavButton)
            
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(snp.width)
            make.height.equalTo(UIScreenBounds.height / 2.5)
        }
        
        productFavButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    internal func showModel(model: ProductModel?) {
        productImageView.sd_setImage(with: URL(string: model?.image ?? ""))
        productTitleLabel.text = model?.title ?? ""
        productRatingAndCountLabel.text = "⭐️" + String(model?.rating.rate ?? 0.0) + "⭐️" + "\tCount: \(String(model?.rating.count ?? 0))"
        productDescriptionLabel.text = model?.description ?? ""
    }
    
    @objc private func favButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        print("tapped")
    }
}
