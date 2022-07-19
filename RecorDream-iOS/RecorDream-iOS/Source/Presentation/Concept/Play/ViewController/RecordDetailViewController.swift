//
//  RecordDetailViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/19.
//

import UIKit

class RecordDetailViewController: UIViewController {
    private var headerView = RecordHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        self.view.addSubview(headerView)
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(67.adjustedHeight)
        }
        self.headerView.setHeaderView(HiddenMoreBtn: false, headerLabelText: "기록 상세보기")
        self.headerView.isHiddenUnderLine = true
    }
}
