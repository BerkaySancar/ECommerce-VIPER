//
//  FavoriteCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 30.06.2023.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
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
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productImageView, productTitleLabel])
        stackView.contentMode = .center
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpConstraints()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(hStackView)
        
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(94)
        }
        
        hStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40)
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func showModel() {
        productImageView.backgroundColor = .gray
        productTitleLabel.text = "SAMSUNG 12231 asdlkajsdlas alsk dalsdasd asd asd asd asd asdasdasd asdassdas"
    }
}
