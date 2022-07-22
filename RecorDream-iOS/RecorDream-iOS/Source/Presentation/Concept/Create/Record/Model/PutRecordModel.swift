//
//  PutRecordModel.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/23.
//

import Foundation

struct PatchRecord: Codable {
    let title: String
    let date: String
    let content: String
    let emotion: Int
    let dreamColor: Int
    let genre: [Int]
    let note: String

    enum CodingKeys: String, CodingKey {
        case title, date, content, emotion
        case dreamColor = "dream_color"
        case genre, note
    }
}
