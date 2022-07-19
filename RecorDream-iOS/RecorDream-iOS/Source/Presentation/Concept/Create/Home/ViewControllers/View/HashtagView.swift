//
//  HashtagView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/13.
//

import UIKit

import SnapKit
import Then

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 3.0, left: 6.0, bottom: 3.0, right: 6.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
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

class HashtagView: BaseView {
    lazy var paddingLabel = BasePaddingLabel().then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    override func setupView() {
        super.setupView()
        addSubview(paddingLabel)
    }
    
    override func setupConstraint() {
        super.setupConstraint()
        paddingLabel.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
    }
    
    func setLabelText(text: String, textColor: String, textBackgroundColor: String, textTypo: UIFont) {
        paddingLabel.backgroundColor = UIColor(named: textBackgroundColor)
        paddingLabel.text = text
        paddingLabel.textColor = UIColor(named: textColor)
        paddingLabel.font = textTypo
    }
}
