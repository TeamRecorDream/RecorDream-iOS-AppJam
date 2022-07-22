//
//  DreamBaseModel.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/22.
//

import Foundation

// MARK: - DreamBaseModel
struct DreamBaseModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DatasClass?
}

// MARK: - DataClass
struct DatasClass: Codable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
    }
}


