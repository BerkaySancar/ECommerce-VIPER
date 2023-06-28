//
//  HomeHeader.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import UIKit

final class CustomNavBarView: UIView {
    
    static let identifier = "HomeHeader"
    
    private lazy var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 27
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profilePhotoImageView, userNameLabel])
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(stackView)
        
        profilePhotoImageView.backgroundColor = .red
        userNameLabel.text = "berkay"
        
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(54)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
    }
}