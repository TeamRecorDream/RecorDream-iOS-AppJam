//
//  CreateRecordModel.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/22.
//

import Foundation

struct CreateRecord: Codable {
    let title: String
    let date: String
    let content: String?
    let emotion: Int?
    let dreamColor: Int?
    let genre: [Int]
    let note: String?
    let voice: String
    let writer: String

    enum CodingKeys: String, CodingKey {
        case title, date, content, emotion
        case dreamColor = "dream_color"
        case genre, note, voice, writer
    }
}
