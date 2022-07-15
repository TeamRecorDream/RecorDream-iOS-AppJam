//
//  EmotionType.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/15.
//

import Foundation

extension Constant {
    enum Emotion {
        static let emotionTitles = [ImageList.emojiBlank.name , ImageList.emojiJoy.name, ImageList.emojiShocked.name, ImageList.emojiLove.name, ImageList.emojiShy.name, ImageList.emojiSad.name, ImageList.emojiAngry.name]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let i):
                return Emotion.emotionTitles[i < Emotion.emotionTitles.count ? i : 0]
            }
        }
    }
}
