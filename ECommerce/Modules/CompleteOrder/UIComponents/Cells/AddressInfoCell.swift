//
//  AddressInfoCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

protocol AddressInfoCellButtonDelegate: AnyObject {
    func addUpdateTappedFromAddress()
}

final class AddressInfoCell: UICollectionViewCell {
    
    static let identifier = "AddressInfoCell"
    
    private lazy var deliveryAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery Address"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var addUpdateAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add / Update", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(addUpdateTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add New Address", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var dropDownButton: UIDropDown = {
        let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: self.frame.width - 16, height: 30))
        drop.center = CGPoint(x: self.frame.midX - 16, y: self.frame.midY - 20)
        drop.placeholder = "Select delivery address"
        return drop
    }()
    
    weak var delegate: AddressInfoCellButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(deliveryAddressLabel)
        contentView.addSubview(addUpdateAddressButton)
        addSubview(dropDownButton)
        
        deliveryAddressLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        addUpdateAddressButton.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryAddressLabel)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    @objc
    private func addUpdateTapped() {
        delegate?.addUpdateTappedFromAddress()
        dropDownButton.options = []
    }
    
    func showAddres(addresses: [AddressModel]?) {
        if let addresses {
            for address in addresses {
                self.dropDownButton.options.append(address.name)
            }
        }
    }
}
