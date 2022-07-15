//
//  BackgroundType.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/15.
//

import Foundation

extension Constant {
    enum BackgroundColor {
        static let backgroundColorTitles = [ImageList.mainCardColorDark.name, ImageList.mainCardColorGreen.name, ImageList.mainCardColorBlue.name, ImageList.mainCardColorOrange.name, ImageList.mainCardColorPurple.name,  ImageList.mainCardColorPink.name, ImageList.mainCardColorRed.name]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let i):
                return BackgroundColor.backgroundColorTitles[i < BackgroundColor.backgroundColorTitles.count ? i : 0]
            }
        }
    }
    
    enum TextColor {
        static let textColorTitles = ["sub_dark01", "sub_green01", "sub_blue01", "sub_orange01", "sub_purple01", "sub_pink01", "sub_red01"]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let i):
                return TextColor.textColorTitles[i < TextColor.textColorTitles.count ? i : 0]
            }
        }
    }
}
