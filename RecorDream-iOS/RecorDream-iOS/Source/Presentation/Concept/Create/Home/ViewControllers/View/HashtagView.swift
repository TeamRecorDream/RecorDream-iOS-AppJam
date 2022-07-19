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
    var padding = UIEdgeInsets(top: 3.0, left: 6.0, bottom: 3.0, right: 6.0)

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
    
    func setPadding(padding: UIEdgeInsets) {
        self.padding = padding
    }
}

class HashtagView: BaseView {
    lazy var paddingLabel = BasePaddingLabel().then {
        $0.backgroundColor = .white
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
    
    func setLabelText(text: String, color: String, textTypo: UIFont){
        paddingLabel.text = text
        paddingLabel.textColor = UIColor(named: color)
        paddingLabel.font = textTypo
    }
    
    
    func setRecordLabel(text: String) {
        paddingLabel.backgroundColor = ColorType.darkBlue02.color
        paddingLabel.text = text
        paddingLabel.textColor = ColorType.white02.color
        paddingLabel.font = TypoStyle.title2.font
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.lightBlue02.color.cgColor) // TODO: - light_blue03
    }
    
    func setSelectedRecordLabel() {
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.subPurple01.color.cgColor)
        paddingLabel.textColor = ColorType.subPurple01.color
    }
    
    func resetSelectedRecordLabel() {
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.lightBlue02.color.cgColor)
        paddingLabel.textColor = ColorType.white02.color
    }
}
