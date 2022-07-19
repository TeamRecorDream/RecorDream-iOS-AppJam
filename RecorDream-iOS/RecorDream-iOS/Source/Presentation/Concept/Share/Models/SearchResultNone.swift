//
//  SearchResultNone.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import UIKit

struct SearchResultNone: Codable {
    let recordsCount: Int
    let records: [SearchNone]?
    
    enum CodingKeys: String, CodingKey {
        case recordsCount = "records_count"
        case records
    }
}

struct SearchNone: Codable { }
