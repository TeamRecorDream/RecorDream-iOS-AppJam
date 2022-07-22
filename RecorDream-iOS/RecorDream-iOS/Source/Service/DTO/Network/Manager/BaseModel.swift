//
//  BaseModel.swift
//  RecorDream-iOS
//
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
     var status: Int
     var success: Bool
     var message: String
     var data: T?
 }
