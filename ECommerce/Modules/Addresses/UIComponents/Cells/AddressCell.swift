//
//  AddressCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import UIKit

final class AddressCell: UICollectionViewCell {
    
    static let identifier = "AddressCell"
    
    private lazy var addressNameLabel: PaddingLabel = {
        let label = PaddingLabel(withInsets: 4, 4, 4, 4)
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.cornerRadius = 4
        return label
    }()
    
    private lazy var addressCityAndCountryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var VStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [addressNameLabel, addressCityAndCountryLabel, addressLabel], spacing: 26)
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints () {
        addSubview(VStackView)
        addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).inset(16)
        }
     
        VStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    func showModel(model: AddressModel?) {
        addressNameLabel.text = model?.name ?? ""
        addressCityAndCountryLabel.text = "\(model?.city ?? ""), \(model?.country ?? "")"
        addressLabel.text = String(model?.buildingNumber ?? 0)
    }
}
