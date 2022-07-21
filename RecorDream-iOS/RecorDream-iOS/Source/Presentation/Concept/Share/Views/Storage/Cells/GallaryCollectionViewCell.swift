//
//  GallaryCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

import HeeKit

final class GallaryCollectionViewCell: UICollectionViewCell, Presentable {
    // MARK: - Properties
    private lazy var emotionImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private lazy var dateLabel = UILabel().then {
        $0.textColor = ColorType.white01.color
        $0.font = TypoStyle.subtitle6.font
    }
    private lazy var descriptionLabel = UILabel().then {
        $0.textColor = ColorType.white01.color
        $0.font = TypoStyle.subtitle4.font
        $0.numberOfLines = 2
        $0.lineBreakMode = .byCharWrapping
    }
    let hashtagLabel = BasePaddingLabel.init(
        padding: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    ).then {
        $0.backgroundColor = ColorType.white01.color
        $0.textAlignment = .center
        $0.textColor = ColorType.subGreen01.color
        $0.font = TypoStyle.subtitle7.font
        $0.makeRounded(radius: 2)
    }
    let hashtagStackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 3
    }
    
    // MARK: - Render
    func setupView() {
        self.addSubviews(emotionImageView, dateLabel, descriptionLabel, hashtagStackView)
        self.hashtagStackView.addArrangedSubview(hashtagLabel)
    }
    func setupConstraint() {
        self.emotionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62)
            make.leading.equalToSuperview().offset(21)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(emotionImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(21)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(21)
        }
        self.hashtagStackView.snp.makeConstraints { make in
            make.height.equalTo(16.adjustedHeight)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(21)
        }
    }
}
