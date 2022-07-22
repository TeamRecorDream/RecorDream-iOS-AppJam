//
//  UserInformationModel.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/21.
//

import Foundation

struct UserInformationModel: Codable {
    let nickname: String
    let email: String
    let is_active: Bool
    let time: String?
    let is_deleted: Bool
}
