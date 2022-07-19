//
//  SearchHeaderTableViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

import HeeKit

final class SearchHeaderTableViewCell: UITableViewHeaderFooterView, Presentable {
    let recordCountLabel = UILabel().then {
        $0.font = TypoStyle.subtitle4.font
        $0.text = "5개의 기록"  // TODO: - 서버통신 결과에 맞게 처리
        $0.textColor = ColorType.white01.color
        $0.sizeToFit()
    }
    
    // MARK: - Functions
    func setupView() {
        self.contentView.addSubview(recordCountLabel)
    }
    func setupConstraint() {
        self.contentView.snp.makeConstraints { make in
            make.width.equalTo(375.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
        }
        self.recordCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(16)
        }
    }
}
