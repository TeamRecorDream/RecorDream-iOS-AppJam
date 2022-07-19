//
//  BaseModel.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
    var status: Int
    var success: Bool
    var message: String?
    var data: T?
}
