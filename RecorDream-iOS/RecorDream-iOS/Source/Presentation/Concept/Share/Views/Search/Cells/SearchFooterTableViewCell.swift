//
//  SearchFooterTableViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

import HeeKit

final class SearchFooterTableViewCell: UITableViewHeaderFooterView, Presentable {
    private lazy var logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = ImageList.rdLogoGrey.image
    }
    
    // MARK: - Render
    func setupView() {
        self.contentView.addSubview(logoImageView)
    }
    func setupConstraint() {
        self.contentView.snp.makeConstraints { make in
            make.width.equalTo(375.adjustedWidth)
            make.height.equalTo(80.adjustedHeight)
        }
        self.logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
    }
}
