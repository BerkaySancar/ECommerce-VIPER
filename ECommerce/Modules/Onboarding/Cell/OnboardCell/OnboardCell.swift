//
//  OnboardCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 25.06.2023.
//

import UIKit

protocol OnboardCellButtonDelegate: AnyObject {
    func nextStartButtonTapped(title: String)
}

final class OnboardCell: UICollectionViewCell {
    
    static let identifier = "OnboardCell"
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 44)
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 4
        return label
    }()
    
    private lazy var nextStartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
  
    weak var delegate: OnboardCellButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped() {
        if let title = nextStartButton.titleLabel?.text {
            delegate?.nextStartButtonTapped(title: title)
        }
    }
   
    private func setupConstraints() {
        addSubview(backgroundImage)
        contentView.addSubview(nextStartButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.centerY).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalTo(titleLabel)
        }
        
        nextStartButton.snp.makeConstraints { make in
            make.centerY.equalTo(UIScreen.main.bounds.height - 16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(44)
        }
    }
    
    internal func showModel(model: OnboardCellViewModel) {
        backgroundImage.image = model.image
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        nextStartButton.setTitle(model.buttonTitle, for: .normal)
    }
}
