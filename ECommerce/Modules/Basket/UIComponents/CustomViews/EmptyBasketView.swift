//
//  EmptyBasketView.swift
//  ECommerce
//
//  Created by Berkay Sancar on 9.07.2023.
//

import UIKit

final class EmptyBasketView: UIView {
    
    private lazy var basketImageView: UIImageView = {
        let image = UIImage(systemName: "basket", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 40))
        let imageView = UIImageView(image: image)
        imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var emptyMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .thin)
        label.textColor = .label
        label.text = "Your basket is empty."
        return label
    }()
    
    private lazy var vStackView: VerticalStackView = {
        let stackView = VerticalStackView(arrangedSubviews: [emptyMessageLabel, basketImageView], spacing: 8)
        stackView.alignment = .center
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
