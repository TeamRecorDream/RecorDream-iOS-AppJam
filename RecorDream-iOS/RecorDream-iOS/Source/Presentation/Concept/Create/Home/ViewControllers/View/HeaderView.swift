//
//  HeaderView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.
//

import UIKit

import SnapKit
import Then

class HeaderView: BaseView {
    // MARK: - Properties
    let logo = UIImageView().then {
        $0.image = UIImage(named: ImageList.rdLogoPurple.name)
    }
    
    let searchButton = UIButton().then {
        $0.setImage(UIImage(named: ImageList.icnSearch.name), for: .normal)
    }
    
    let profileButton = UIButton().then {
        $0.setImage(UIImage(named: ImageList.icnMypage.name), for: .normal)
    }
    
    lazy var iconStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.addArrangedSubviews(searchButton, profileButton)
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        addSubviews(logo,iconStackView)
    }
    
    override func setupConstraint() {
        super.setupConstraint()
        
        logo.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.height.equalTo(16)
            make.leading.equalToSuperview().offset(17)
            make.centerY.equalToSuperview()
        }
        
        [searchButton,profileButton].forEach {
            $0.snp.makeConstraints { make in
                make.height.width.equalTo(24)
            }
        }
        
        iconStackView.snp.makeConstraints { make in
            make.width.equalTo(52)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
}
