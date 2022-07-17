//
//  RecordViewController.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/17.
//

import UIKit

import HeeKit
import SnapKit
import Then

class RecordViewController: BaseViewController, Presentable, HeaderViewDelegate {
    // MARK: - Properties
    var headerView = RecordHeaderView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setHeaderView()
        headerView.delegate = self
    }
    
    // MARK: - Functions
    func setupConstraint() {
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(67.adjustedHeight)
        }
    }

    func setupView() {
        self.view.addSubview(headerView)
    }
    
    private func setHeaderView(){
        headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "기록하기")
    }
    
    func BackButtonDidTap() {
        print("backBtnTap")
    }
    
    func MoreButtonDidTap() {}

}
