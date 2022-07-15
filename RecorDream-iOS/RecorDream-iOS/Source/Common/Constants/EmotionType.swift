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
    
    enum EmotionOff {
        static let emotionTitles = [
            ImageList.emojiBlankOff.name, ImageList.emojiJoyOff.name,
            ImageList.emojiShockedOff.name, ImageList.emojiLoveOff.name, ImageList.emojiShyOff.name, ImageList.emojiLoveOff.name, ImageList.emojiShyOff.name, ImageList.emojiSadOff.name, ImageList.emojiAngryOff.name
        ]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let i):
                return EmotionOff.emotionTitles[i < EmotionOff.emotionTitles.count ? i : 0
                ]
            }
        }
    }
}
