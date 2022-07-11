//
//  BaseView.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/07.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() { }
    func setupConstraint() { }
}
