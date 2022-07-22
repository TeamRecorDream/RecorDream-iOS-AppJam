//
//  RecordDetailModel.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/22.
//

import Foundation

struct RecordDetailModel: Codable {
    let _id: String
    let writer: String
    let date: String
    let title: String
    let voice: VoiceModel?
    let content: String?
    let emotion: Int
    let dream_color: Int
    let genre: [Int]
    let note: String?
}

struct VoiceModel: Codable {
    let _id: String
    let url: String
}
