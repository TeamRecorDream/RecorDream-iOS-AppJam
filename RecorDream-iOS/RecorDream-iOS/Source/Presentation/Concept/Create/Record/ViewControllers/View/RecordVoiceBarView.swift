//
//  RecordVoiceBarView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/18.
//

import UIKit

import SnapKit
import Then

class RecordVoiceBarView: BaseView {
    //MARK: - Properties
    private let voiceIconImage = UIImageView().then {
        $0.image = UIImage(named: ImageList.icnMic.name)
        $0.tintColor = ColorType.white01.color
    }
    
    private let voiceLabel = UILabel().then {
        $0.text = "음성녹음"
        $0.font = TypoStyle.title2.font
    }
    
    private let recordTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.font = TypoStyle.title2.font
    }

    private let detailIconImage = UIImageView().then {
        $0.image = UIImage(named: ImageList.icnPlay.name)?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = ColorType.white01.color
    }
    
    private lazy var voiceView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
    }
    
    override func setupView() {
        voiceView.addSubviews(voiceIconImage, voiceLabel, recordTimeLabel, detailIconImage)
        addSubview(voiceView)
    }
    
    override func setupConstraint() {
        voiceIconImage.snp.makeConstraints { make in
            make.width.equalTo(24.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        voiceLabel.snp.makeConstraints { make in
            make.leading.equalTo(voiceIconImage.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
        }
        
        detailIconImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(14.adjustedWidth)
            make.height.equalTo(14.adjustedHeight)
            make.centerY.equalToSuperview()
        }
        
        recordTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(detailIconImage.snp.leading).offset(-6)
            make.centerY.equalToSuperview()
        }
        
        voiceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
