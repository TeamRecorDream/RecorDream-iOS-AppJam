//
//  ColorType.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

enum ColorType: String, CaseIterable {
    // storagy list tagchip box
    case black01 = "black01"
    case black02 = "black02"
    case darkBlue01 = "dark_blue01"
    case darkBlue02 = "dark_blue02"
    case darkBlue03 = "dark_blue03"
    case gray = "gray"
    case lightBlue01 = "light_blue01"
    case lightBlue02 = "light_blue02"
    case lightBlue03 = "light_blue03"
    case red = "red"
    case subBlue02 = "sub_blue02"
    case subDark02 = "sub_dark2"
    case subGreen02 = "sub_green02"
    case subOrange02 = "sub_orange02"
    case subPink02 = "sub_pink02"
    case subPurple02 = "sub_purple02"
    case subRed02 = "sub_red02"
    case white01 = "white01"
    case white02 = "white02"
    case white03 = "white03"
    case white04 = "white04"
    
    // tagchip text
    case subBlue01 = "sub_blue01"
    case subDark01 = "sub_dark01"
    case subGreen01 = "sub_green01"
    case subOrange01 = "sub_orange01"
    case subPink01 = "sub_pink01"
    case subPurple01 = "sub_purple01"
    case subRed01 = "sub_red01"
    
    case warningGray = "warning_gray"
    
    var name: String {
        return self.rawValue
    }
}
