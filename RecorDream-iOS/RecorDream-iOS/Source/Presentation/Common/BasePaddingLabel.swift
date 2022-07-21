//
//  BasePaddingLabel.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

final class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets()

    convenience init(padding: UIEdgeInsets) {
        self.init(frame: .zero)
        
        self.padding = padding
    }
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}


