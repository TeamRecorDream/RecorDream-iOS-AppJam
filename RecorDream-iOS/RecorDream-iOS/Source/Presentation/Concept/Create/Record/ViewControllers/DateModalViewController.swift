//
//  RecordModalViewController.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/20.
//

import UIKit

import SnapKit
import Then
import HeeKit

class DateModalViewController: BaseViewController {
    let dateView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
//        $0.makeRoundedSpecificCorner(corners: .topLeft, cornerRadius: 12)
//        $0.makeRoundedSpecificCorner(corners: .topRight, cornerRadius: 12)
    }
    
    lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
    }
    
    let noticeLabel = UILabel().then {
        $0.text = "날짜 설정"
        $0.font = TypoStyle.title2.font
        $0.textColor = ColorType.white01.color
    }
    
    let dateSaveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.titleLabel?.font = TypoStyle.title2.font
        $0.setTitleColor(ColorType.white01.color, for: .normal)
    }
    
    static var saveDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func setTargets() {
        datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        dateSaveButton.addTarget(self, action: #selector(dateSaveButtonDidTap), for: .touchUpInside)
    }
}

extension DateModalViewController: Presentable {
    func setupView() {
        view.backgroundColor = ColorType.black02.color
        self.view.addSubview(dateView)
        dateView.addSubviews(noticeLabel, dateSaveButton, datePicker)
    }

    func setupConstraint() {
        self.dateView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(318.adjustedHeight)
        }
        
        self.noticeLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(25)
        }
        
        self.dateSaveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(27)
            make.height.equalTo(14.adjustedHeight)
        }
        
        self.datePicker.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(dateView)
        }
    }
}

extension DateModalViewController {
    @objc func onDidChangeDate(sender: UIDatePicker) {
        print(sender.date)
        DateModalViewController.saveDate = sender.date
    }
    
    @objc func dateSaveButtonDidTap() {
        print("clicked")
        print(DateModalViewController.saveDate)
    }
}
