//
//  StorageResultNone.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

struct StorageResultNone: Codable {
    let recordsCount: Int = 0
    let records: [EmptyList] = []
    
    enum CodingKeys: String, CodingKey {
        case recordsCount = "records_count"
        case records
    }
}

struct EmptyList: Codable { }
