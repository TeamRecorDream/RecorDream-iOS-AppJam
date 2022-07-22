//
//  CreateEndPoint.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/21.
//

import Foundation

enum DreamEndPoint {
    case getRecorDreamCard
    case postRecorDream(recordData: CreateRecord)
//    case patchRecorDream(recordId: String)
}

extension DreamEndPoint: EndPoint {
    var method: HTTPMethod {
        switch self {
        case .getRecorDreamCard:
            return .GET
        case .postRecorDream(recordData: _):
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case .getRecorDreamCard:
            return nil
        case .postRecorDream(recordData: let recordData):
            return try! JSONSerialization.data(withJSONObject: recordData) //TODO: - 강제 형변환함
        }
    }
    
    func setURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getRecorDreamCard:
            return "\(baseURL)/record"
        case .postRecorDream(recordData: _):
            return "\(baseURL)/record"
        }
    }
}
