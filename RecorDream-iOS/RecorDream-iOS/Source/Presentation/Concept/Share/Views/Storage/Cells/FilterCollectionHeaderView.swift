//
//  FilterCollectionHeaderView.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

import HeeKit

final class FilterCollectionHeaderView: UICollectionReusableView, Presentable {
    private lazy var headerTitle = UILabel().then {
        $0.font = TypoStyle.subtitle4.font
        $0.text = "나의 감정"
        $0.textColor = ColorType.white01.color
    }
    
    func setupView() {
        self.addSubview(headerTitle)
        self.backgroundColor = ColorType.white04.color
    }
    func setupConstraint() {
        self.headerTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
    }
}
