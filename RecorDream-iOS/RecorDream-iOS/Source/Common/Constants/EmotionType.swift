//
//  EmotionType.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/15.
//

import UIKit

extension Constant {
    enum Emotion {
        static let emotionTitles = [ImageList.emojiAll.name, ImageList.emojiJoy.name, ImageList.emojiShocked.name, ImageList.emojiLove.name, ImageList.emojiShy.name, ImageList.emojiSad.name, ImageList.emojiAngry.name, ImageList.emojiBlank.name]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let emotionNum):
                return Emotion.emotionTitles[emotionNum >= 0 && emotionNum < Emotion.emotionTitles.count ? emotionNum : 7]
            }
        }
    }
    
    enum EmotionOff {
        static let emotionTitles = [
            ImageList.emojiAllOff.name, ImageList.emojiJoyOff.name, ImageList.emojiShockedOff.name, ImageList.emojiLoveOff.name, ImageList.emojiShyOff.name, ImageList.emojiLoveOff.name, ImageList.emojiShyOff.name, ImageList.emojiSadOff.name, ImageList.emojiAngryOff.name, ImageList.emojiBlankOff.name,
        ]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let emotionNum):
                return EmotionOff.emotionTitles[emotionNum >= 0 && emotionNum < EmotionOff.emotionTitles.count ? emotionNum : 7
                ]
            }
        }
    }
}
