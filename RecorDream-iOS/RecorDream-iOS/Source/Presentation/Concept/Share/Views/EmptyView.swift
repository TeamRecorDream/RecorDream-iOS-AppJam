//
//  EmptyView.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

import SnapKit
import Then

extension UITableView {
    func searchEmptyView(message: String) {
        let emptyView = UIView().then {
            $0.frame = CGRect(
                x: self.center.x,
                y: self.center.y,
                width: self.bounds.width,
                height: self.bounds.height)
        }
        let messageLabel = UILabel().then {
            $0.text = message
            $0.textAlignment = .center
            $0.font = TypoStyle.subhead.font
            $0.textColor = ColorType.white01.color
        }
        let logoImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFit
            $0.image = ImageList.rdLogoGrey.image
        }
        
        // MARK: - Render
        emptyView.addSubviews(messageLabel, logoImageView)
        self.backgroundView = emptyView
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(218.adjustedHeight)
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(54.adjustedHeight)
        }
        
        // MARK: - Renounce
        func restore() { self.backgroundView = nil }
    }
}
