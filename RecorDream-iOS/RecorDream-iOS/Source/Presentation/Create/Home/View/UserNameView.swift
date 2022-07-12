//
//  UserNameView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.
//

import UIKit

class UserNameView: BaseView {
    var userName: String? {
        didSet {
            setBoldLabelText()
        }
    }
    
    lazy var welcomeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .ultraLight)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBoldLabelText()
    }
    
    override func setupView() {
        addSubview(welcomeLabel)
    }
    
    override func setupConstraint() {
        welcomeLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func setBoldLabelText() {
        guard let label = welcomeLabel.text else { return }
        var userNameCount: Int
        if let count = userName?.count {
            userNameCount = 8 + count
        } else {
            userNameCount = 8
        }
        
        let attributedStr = NSMutableAttributedString(string: label)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .heavy), range: NSRange.init(location: 0, length: userNameCount))
        welcomeLabel.numberOfLines = 0
        welcomeLabel.attributedText = attributedStr
    }
    
    func setUserName(_ name: String, _ isEmpty: Bool ) {
        welcomeLabel.text = isEmpty
        ? "반가워요, \(name)님!\n꿈의 기록을 채워주세요."
        : "반가워요, \(name)님!\n최근에 어떤 꿈을 꾸셨나요?"
        userName = name
    }
    
    func setWelcomLabel() {
        welcomeLabel.textAlignment = .left
    }
}
