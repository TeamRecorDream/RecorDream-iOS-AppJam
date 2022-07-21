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
    lazy var paddingLabel = BasePaddingLabel.init(padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)).then {
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    static var isTouchedCount:Int = 0
    
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
    
    // MARK: - 기록하기 뷰에 쓰일 함수
    func setRecordLabel(text: String) {
        paddingLabel.backgroundColor = ColorType.darkBlue02.color
        paddingLabel.text = text
        paddingLabel.textColor = ColorType.white02.color
        paddingLabel.font = TypoStyle.title2.font
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.lightBlue03.color.cgColor)
    }
    
    func setSelectedRecordLabel() {
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.subPurple01.color.cgColor)
        paddingLabel.textColor = ColorType.subPurple01.color
    }
    
    func resetSelectedRecordLabel() {
        paddingLabel.makeRoundedWithBorder(radius: 3, borderColor: ColorType.lightBlue03.color.cgColor)
        paddingLabel.textColor = ColorType.white02.color
    }
    
    // MARK: - 선택된 hashtagView의 개수를 세어주는 함수
    func calculateIsTouchCount(addCount: Bool) {
        HashtagView.isTouchedCount = addCount ? HashtagView.isTouchedCount + 1 : HashtagView.isTouchedCount - 1
    }

    func touchedCount() -> Int {
        return HashtagView.isTouchedCount
    }
}
