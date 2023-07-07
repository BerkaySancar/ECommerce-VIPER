//
//  CardInfoCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 6.07.2023.
//

import UIKit

protocol CardInfoCellDelegate: AnyObject {
    func addUpdateTapped()
    func didSelectCard(cardName: String)
}

final class CardInfoCell: UICollectionViewCell {
    
    static let identifier = "CardInfoCell"
    
    private lazy var cardInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Informations"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var addUpdateCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add / Update", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(addUpdateTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var dropDownButton: UIDropDown = {
        let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: self.frame.width - 16, height: 30))
        drop.center = CGPoint(x: self.contentView.frame.midX, y: self.contentView.frame.midY - 20)
        drop.placeholder = "Select your card"
        drop.didSelect { [weak self] cardName, _ in
            guard let self else { return }
            self.delegate?.didSelectCard(cardName: cardName)
        }
        return drop
    }()
    
    private var cards: [CardModel]?
    
    weak var delegate: CardInfoCellDelegate?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(cardInfoLabel)
        contentView.addSubview(addUpdateCardButton)
        contentView.addSubview(dropDownButton)
        
        cardInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        addUpdateCardButton.snp.makeConstraints { make in
            make.centerY.equalTo(cardInfoLabel)
            make.right.equalToSuperview().inset(8)
        }
    }
    
    @objc
    private func addUpdateTapped() {
        delegate?.addUpdateTapped()
        dropDownButton.options = []
        dropDownButton.placeholder = "Select your card"
        delegate?.didSelectCard(cardName: "")
    }
    
    func showCards(cards: [CardModel]?) {
        dropDownButton.options = []
        if let cards {
            for card in cards {
                dropDownButton.options.append(card.cardName)
            }
        }
    }
}
