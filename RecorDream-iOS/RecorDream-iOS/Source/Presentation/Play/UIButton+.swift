//
//  UIButton+.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/17.
//

import UIKit

extension UIButton {
    func setUnderLine(){
        guard let title = title(for: .normal) else {return}
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
