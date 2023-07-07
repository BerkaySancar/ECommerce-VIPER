//
//  VerticalStackView.swift
//  ECommerce
//
//  Created by Berkay Sancar on 28.06.2023.
//

import Foundation
import UIKit.UIStackView

final class VerticalStackView: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
