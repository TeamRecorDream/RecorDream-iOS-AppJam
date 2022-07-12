//
//  FontType.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

enum FontType: String {
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemibold = "Pretendard-SemiBold"
    case pretendardLight = "Pretendard-Light"
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardRegular = "Pretendard-Regular"
    
    var name: String {
        return self.rawValue
    }
}

struct FontDescription {
    let font: FontType
    let size: CGFloat
}
