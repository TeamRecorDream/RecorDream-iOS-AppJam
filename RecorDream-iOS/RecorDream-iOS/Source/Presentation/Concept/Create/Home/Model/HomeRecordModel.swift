//
//  HomeRecordModel.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/21.
//

import Foundation
//
//// MARK: - Record
//
//
//struct Record: Codable {
//    let nickname: String
//    let records: [RecordElement]?
//}
//
//// MARK: - RecordElement
//struct RecordElement: Codable {
//    let id: String
//    let dreamColor, emotion: Int
//    let date, title: String
//    let genre: [Int]
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case dreamColor = "dream_color"
//        case emotion, date, title, genre
//    }
//}

struct Record: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let nickname: String
    let records: [RecordElement]
}

// MARK: - RecordElement
struct RecordElement: Codable {
    let id: String
    let dreamColor, emotion: Int
    let date, title: String
    let genre: [Int]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case dreamColor = "dream_color"
        case emotion, date, title, genre
    }
}
