//
//  EmotionCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/18.
//

import UIKit

import SnapKit
import Then

class EmotionCollectionViewCell: UICollectionViewCell {
    let emotionImageView = UIImageView().then {
        $0.alpha = 0.35
    }
    
    let emotionView = UIView()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        emotionView.addSubview(emotionImageView)
        contentView.addSubview(emotionView)
    }
    
    private func setupConstraints() {
        emotionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emotionImageView.snp.makeConstraints { make in
            make.width.equalTo(36.adjustedWidth)
            make.height.equalTo(36.adjustedHeight)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setEmotionImage(imageName: String) {
        emotionImageView.image = UIImage(named: imageName)
    }
}
