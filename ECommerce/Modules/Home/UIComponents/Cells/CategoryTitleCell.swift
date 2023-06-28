//
//  CategoryTitleCell.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation
import UIKit

final class CategoryTitleCell: UICollectionViewCell {
    
    static let identifier = "CategoryTitleCell"
    
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 8
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(titleTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButton()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        contentView.addSubview(titleButton)
        
        titleButton.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
        titleButton.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(50)
        }
    }
    
    func setTitle(title: String?) {
        titleButton.setTitle(title, for: .normal)
    }
    
    @objc private func titleTapped() {
        print("tapped")
    }
}
