//
//  TypoStyle+.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

extension TypoStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .modal1:
            return FontDescription(font: .pretendardSemibold, size: 28)
        case .modal2:
            return FontDescription(font: .pretendardLight, size: 26)
        case .head1:
            return FontDescription(font: .pretendardBold, size: 24)
        case .head2:
            return FontDescription(font: .pretendardExtraBold, size: 24)
        case .subhead:
            return FontDescription(font: .pretendardSemibold, size: 18)
        case .title1:
            return FontDescription(font: .pretendardBold, size: 20)
        case .title2:
            return FontDescription(font: .pretendardSemibold, size: 18)
        case .subtitle1:
            return FontDescription(font: .pretendardMedium, size: 16)
        case .subtitle2:
            return FontDescription(font: .pretendardLight, size: 16)
        case .subtitle3:
            return FontDescription(font: .pretendardBold, size: 14)
        case .subtitle4:
            return FontDescription(font: .pretendardBold, size: 12)
        case .subtitle5:
            return FontDescription(font: .pretendardBold, size: 10)
        case .subtitle6:
            return FontDescription(font: .pretendardMedium, size: 10)
        case .menu1:
            return FontDescription(font: .pretendardSemibold, size: 16)
        case .menu2:
            return FontDescription(font: .pretendardRegular, size: 16)
        case .body1:
            return FontDescription(font: .pretendardMedium, size: 14)
        case .body2:
            return FontDescription(font: .pretendardLight, size: 14)
        case .cap:
            return FontDescription(font: .pretendardMedium, size: 12)
        case .ic1:
            return FontDescription(font: .pretendardSemibold, size: 10)
        }
    }
    
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont()
        }
        return font
    }
}
