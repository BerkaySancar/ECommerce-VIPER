//
//  ProfileCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import UIKit

final class ProfileCell: UITableViewCell {
    
    static let identifier = "ProfileCell"
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [symbolImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        addSubview(hStackView)
        
        symbolImageView.snp.makeConstraints { make in
            make.width.height.equalTo(36)
        }
        
        hStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    func showModel(model: ProfileRowItemModel?) {
        symbolImageView.image = model?.item.image
        titleLabel.text = model?.item.title
    }
}
