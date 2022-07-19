//
//  SearchResultExsit.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import UIKit

struct SearchResultExsit: Codable {
    let recordsCount: Int
    let records: [SearchExist]?
    
    enum CodingKeys: String, CodingKey {
        case recordsCount = "records_count"
        case records
    }
}

struct SearchExist: Codable {
    let recordID: String
    let dreamColor: Int
    let emotion: Int
    let date: String
    let title: String
    let genreNum: [GenreNumber]?
    
    enum CodingKeys: String, CodingKey {
        case recordID = "_id"
        case dreamColor = "dream_color"
        case genreNum = "genre"
        case emotion, date, title
    }
}

struct GenreNumber: Codable {
    let genre: Int
}
