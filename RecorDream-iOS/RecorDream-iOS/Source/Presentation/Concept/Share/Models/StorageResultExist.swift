//
//  StorageFilterList.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

struct StorageResultExist: Codable {
    let recordID: String
    let dreamColor: Int
    let emotion: Int
    let date: String
    let title: String
    let genre: [StorageResultFilter]?
    
    enum CodingKeys: String, CodingKey {
        case recordID = "_id"
        case dreamColor = "dream_color"
        case emotion, date, title, genre
    }
}

struct StorageResultFilter: Codable {
    let filter: [Int]
}
