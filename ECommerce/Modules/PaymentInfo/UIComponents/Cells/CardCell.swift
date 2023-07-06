//
//  CardCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

protocol CardCellTrashButtonDelegate: AnyObject {
    func trashTapped(model: CardModel?)
}

class CardCell: UICollectionViewCell {
    
    static let identifier = "CardCell"
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .thin)
        return label
    }()
    
    private lazy var cardNumber: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var vStackView: UIStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [cardNameLabel,
                                                             cardNumber], spacing: 16)
        stackView.alignment = .leading
        return stackView
    }()
    
    private var model: CardModel?
    weak var delegate: CardCellTrashButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(vStackView)
        contentView.addSubview(trashButton)

        trashButton.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).inset(16)
            make.top.equalToSuperview().offset(14)
        }
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func trashButtonTapped() {
        delegate?.trashTapped(model: self.model)
    }
    
    func showModel(model: CardModel?) {
        self.model = model
        self.cardNameLabel.text = model?.cardName ?? ""
        self.cardNumber.text = model?.cardNumber
    }
}
