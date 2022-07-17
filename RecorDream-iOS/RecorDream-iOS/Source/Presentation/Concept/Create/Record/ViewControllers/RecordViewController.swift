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

class RecordViewController: BaseViewController {
    // MARK: - Properties
    private var headerView = RecordHeaderView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setHeaderView()
        setDelegate()
    }
    
    // MARK: - Functions
    private func setHeaderView() {
        headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "기록하기")
    }
    
    private func setDelegate() {
        headerView.delegate = self
    }
}

extension RecordViewController: Presentable, HeaderViewDelegate {
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
    
    func BackButtonDidTap() {
        print("backBtnTap")
    }
    
    func MoreButtonDidTap() {}

}
