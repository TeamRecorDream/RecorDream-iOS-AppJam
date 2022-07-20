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
    static var saveDate = Date()
    var dateClosure: ((Date)->())?
    let dateView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
//        $0.makeRoundedSpecificCorner(corners: .topLeft, cornerRadius: 12)
//        $0.makeRoundedSpecificCorner(corners: .topRight, cornerRadius: 12)
    }
    
    lazy var datePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .date
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = TypoStyle.title2.font
        $0.setTitleColor(ColorType.white01.color, for: .normal)
    }
    
    let dateSaveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.titleLabel?.font = TypoStyle.title2.font
        $0.setTitleColor(ColorType.white01.color, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
    }
    
    override func setTargets() {
        datePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        dateSaveButton.addTarget(self, action: #selector(dateSaveButtonDidTap), for: .touchUpInside)
    }
}

extension DateModalViewController: Presentable {
    func setupView() {
        view.backgroundColor = ColorType.black02.color
        self.view.addSubview(dateView)
        dateView.addSubviews(cancelButton, dateSaveButton, datePicker)
    }

    func setupConstraint() {
        self.dateView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(318.adjustedHeight)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(27)
            make.height.equalTo(14.adjustedHeight)
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
        DateModalViewController.saveDate = sender.date
    }
    
    @objc func cancelButtonDidTap() {
        self.dismiss(animated: true)
    }
    
    @objc func dateSaveButtonDidTap() {
        dateClosure?(DateModalViewController.saveDate)
        self.dismiss(animated: true)
    }
}
