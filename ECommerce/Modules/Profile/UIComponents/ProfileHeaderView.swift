//
//  ProfileHeaderView.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIView

final class ProfileHeaderView: UIView {
    
    private lazy var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "sberkalskdj"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var vStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [profilePhotoImageView, emailLabel], spacing: 36)
        stackView.contentMode = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        addSubview(vStackView)
        
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(44)
        }
        
        vStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
