//
//  RecorDreamView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.
//

import UIKit

class RecorDreamView: BaseView {
    let userNameView = UserNameView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        userNameView.setWelcomLabel()
    }
    
    override func setupView() {
        addSubviews(userNameView)
    }
    
    override func setupConstraint() {
        userNameView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(23)
            make.top.equalToSuperview().offset(11)
        }
    }
    
    func setUserName(_ name: String, _ isEmpty: Bool) {
        userNameView.setUserName(name, isEmpty)
    }
}
