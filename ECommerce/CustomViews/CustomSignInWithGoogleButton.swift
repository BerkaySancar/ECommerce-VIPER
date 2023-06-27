//
//  CustomSignInWithGoogleButton.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import UIKit

@IBDesignable
final class CustomSignInWithGoogleButton: UIButton {
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "googleLogo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.setTitle("Sign in with Google", for: .normal)
        self.setTitleColor(.label, for: .normal)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.lightGray.cgColor

        addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(50)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(32)
        }
    }
}
