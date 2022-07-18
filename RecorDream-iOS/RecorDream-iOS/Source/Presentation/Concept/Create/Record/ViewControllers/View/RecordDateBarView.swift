//
//  RecordBarView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/18.
//

import UIKit

import SnapKit
import Then

class RecordDateBarView: BaseView {
    //MARK: - Properties
    private let calendarIconImage = UIImageView().then {
        $0.image = UIImage(named: ImageList.icnCalender.name)
        $0.tintColor = ColorType.white01.color
    }
    
    private let dateLabel = UILabel().then {
        $0.text = "날짜"
        $0.font = TypoStyle.title2.font
    }
    
    private let recordDateLabel = UILabel().then {
        $0.text = "2022-06-27"
        $0.font = TypoStyle.title2.font
    }

    private let detailIconImage = UIImageView().then {
        $0.image = UIImage(named: ImageList.icnAllowForwardGray.name)?.withRenderingMode(.alwaysTemplate)
        $0.tintColor = ColorType.white01.color
    }
    
    let detailStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private lazy var dateView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
        // TODO: - lightBlue03 으로 수정하기 
    }
    
//    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))

//    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    override func setupView() {
//        tapGesture.delegate = self
//        recordDateLabel.addGestureRecognizer(tapGesture)
//        
        detailStackView.addArrangedSubviews(recordDateLabel, detailIconImage)
        dateView.addSubviews(calendarIconImage, dateLabel, detailStackView)
//        dateView.sendSubviewToBack(detailStackView)
        addSubview(dateView)
    }
    
    override func setupConstraint() {
        calendarIconImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(calendarIconImage.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
        }
        
        detailIconImage.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(14)
//            make.centerY.equalToSuperview()
        }
        
//        recordDateLabel.snp.makeConstraints { make in
//            make.trailing.equalTo(detailIconImage.snp.leading).offset(-6)
//            make.centerY.equalToSuperview()
//        }
        
        detailStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        dateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func tapMethod(sender: UITapGestureRecognizer) {
        print("help mee plzzzz")
    }
}

//extension RecordDateBarView: UIGestureRecognizerDelegate {
//    func gestureRecognizer(
//        _ gestureRecognizer: UIGestureRecognizer,
//        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
//    ) -> Bool {
//        return true
//    }
//}

