//
//  HashtagView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/13.
//

import UIKit

import SnapKit
import Then

class HashtagView: BaseView {
    lazy var paddingLabel = BasePaddingLabel.init(padding: UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)).then {
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
