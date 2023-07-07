//
//  UserInfoView.swift
//  ECommerce
//
//  Created by Berkay Sancar on 1.07.2023.
//

import Foundation
import UIKit.UIView
import SDWebImage

final class UserInfoView: UIView {
    
    private lazy var profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.label.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var vStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [profilePhotoImageView, emailLabel], spacing: 48)
        stackView.alignment = .center
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
    
    private func setUpConstraints() {
        addSubview(vStackView)
        
        profilePhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(140)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(44)
        }
        
        vStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func showModel(model: CurrentUserModel?) {
        profilePhotoImageView.sd_setImage(with: URL(string: model?.profileImageURLString ?? "https://picsum.photos/seed/picsum/500/500"))
        emailLabel.text = model?.userEmail ?? ""
    }
}
