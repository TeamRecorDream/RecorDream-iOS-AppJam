//
//  StorageHeaderView.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

import HeeKit

final class StorageHeaderView: BaseView {
    let headerTitleLabel = UILabel().then {
        $0.font = TypoStyle.subtitle4.font
        $0.textColor = ColorType.white01.color
    }
    let gallaryButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.imageView?.image = ImageList.icnGallaryOn.image
    }
    let seperatorView = UIView().then {
        $0.backgroundColor = ColorType.white01.color
    }
    let listButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.imageView?.image = ImageList.icnListOn.image
    }
    
    // MARK: - Render
    override func setupView() {
        self.addSubviews(headerTitleLabel, gallaryButton, seperatorView, listButton)
    }
    override func setupConstraint() {
        self.headerTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(16)
        }
        self.gallaryButton.snp.makeConstraints { make in
            make.width.equalTo(46.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
            make.centerX.centerY.equalTo(headerTitleLabel)
            make.leading.equalTo(headerTitleLabel.snp.trailing).offset(184)
        }
        self.seperatorView.snp.makeConstraints { make in
            make.width.equalTo(2.adjustedWidth)
            make.height.equalTo(10.5.adjustedHeight)
            make.centerX.centerY.equalTo(headerTitleLabel)
            make.leading.equalTo(gallaryButton.snp.trailing).offset(6)
        }
        self.listButton.snp.makeConstraints { make in
            make.width.equalTo(49.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
            make.centerX.centerY.equalTo(headerTitleLabel)
            make.trailing.equalToSuperview().offset(16)
        }
    }
}
