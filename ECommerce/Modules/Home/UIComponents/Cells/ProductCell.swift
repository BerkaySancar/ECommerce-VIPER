//
//  ProductCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    static let identifier = "ProductCell"
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var productFavButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.setImage(UIImage(systemName: "heart"), for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: UIControl.State.selected)
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var verticalStackView = VerticalStackView(arrangedSubviews: [productImageView,
                                                                              productPriceLabel,
                                                                              productTitleLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(verticalStackView)
        contentView.addSubview(productFavButton)
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(snp.width)
            make.height.equalTo(snp.height).inset(56)
        }
        
        productFavButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(5)
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(28)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    internal func showModel(title: String) {
        self.productPriceLabel.text = title
        self.productTitleLabel.text = "Computer or something"
    }
    
    @objc
    private func favButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
}
