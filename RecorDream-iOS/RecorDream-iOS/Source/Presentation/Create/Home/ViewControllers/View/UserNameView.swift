//
//  UserNameView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.
//

import UIKit
import SnapKit
import Then

class UserNameView: BaseView {
    let welcomeTopLabel = UILabel().then {
        $0.font = TypoStyle.head1.font
    }
    
    let welcomeBottomLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .ultraLight) //TODO: - typo 추가하기
    }
    
    lazy var welcomeStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
        $0.addArrangedSubviews(welcomeTopLabel, welcomeBottomLabel)
    }

    override func setupView() {
        addSubview(welcomeStackView)
    }
    
    override func setupConstraint() {
        welcomeStackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setUserNameView(_ name: String, _ isEmpty: Bool ) {
        welcomeTopLabel.text = "반가워요, \(name)님!"
        welcomeBottomLabel.text = isEmpty
        ? "꿈의 기록을 채워주세요."
        : "최근에 어떤 꿈을 꾸셨나요?"
        welcomeStackView.alignment = isEmpty ? .center : .leading
    }
    
}
