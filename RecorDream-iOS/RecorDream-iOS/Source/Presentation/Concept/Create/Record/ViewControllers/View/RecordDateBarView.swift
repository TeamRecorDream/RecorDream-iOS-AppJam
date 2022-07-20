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
    
    var recordDateLabel = UILabel().then {
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
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRecordDateLabel(date: Date())
    }
    
    override func setupView() {
        detailStackView.addArrangedSubviews(recordDateLabel, detailIconImage)
        dateView.addSubviews(calendarIconImage, dateLabel, detailStackView)
        addSubview(dateView)
    }
    
    override func setupConstraint() {
        calendarIconImage.snp.makeConstraints { make in
            make.width.equalTo(24.adjustedWidth)
            make.height.equalTo(24.adjustedHeight)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(calendarIconImage.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
        }
        
        detailIconImage.snp.makeConstraints { make in
            make.width.equalTo(14.adjustedWidth)
            make.height.equalTo(14.adjustedHeight)
        }
        
        detailStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        dateView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setRecordDateLabel(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertDate = dateFormatter.string(from: date)
        recordDateLabel.text = convertDate
    }
}
