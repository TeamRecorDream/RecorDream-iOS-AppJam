//
//  CreateEndPoint.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/21.
//

import Foundation

enum DreamEndPoint {
    case getRecorDreamCard
//    case postRecorDream(userId: Int, date: Date, title: String, writer: String)
//    case patchRecorDream(recordId: String)
}

extension DreamEndPoint: EndPoint {
    var method: HTTPMethod {
        switch self {
        case .getRecorDreamCard:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getRecorDreamCard:
            return nil
        }
    }
    
    func setURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getRecorDreamCard:
            return "\(baseURL)/record"
        }
    }
}
