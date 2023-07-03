//
//  AddressCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 2.07.2023.
//

import UIKit

protocol AddressCellTrashButtonDelegate: AnyObject {
    func trashTapped(model: AddressModel?)
}

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
    
    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
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
    
    private var model: AddressModel?
    weak var delegate: AddressCellTrashButtonDelegate?
    
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
        contentView.addSubview(trashButton)
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).inset(16)
        }
        
        trashButton.snp.makeConstraints { make in
            make.centerX.equalTo(arrowImageView)
            make.top.equalToSuperview().offset(14)
        }
     
        VStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func trashButtonTapped() {
        delegate?.trashTapped(model: self.model)
    }
    
    func showModel(model: AddressModel?) {
        self.model = model
        addressNameLabel.text = model?.name ?? ""
        addressCityAndCountryLabel.text = "\(model?.city ?? ""), \(model?.country ?? "")"
        addressLabel.text = "\(model?.street ?? ""), No: \(model?.buildingNumber ?? 0), ZIP: \(model?.zipCode ?? 0)"
    }
}
