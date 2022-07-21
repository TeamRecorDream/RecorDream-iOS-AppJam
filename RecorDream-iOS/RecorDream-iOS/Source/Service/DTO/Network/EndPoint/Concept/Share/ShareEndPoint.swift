//
//  ShareEndPoint.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/21.
//

import Foundation

enum ShareEndPoint {
    case getSearchingKeyword(keyword: String)
}

extension ShareEndPoint: EndPoint {
    var method: HTTPMethod {
        switch self {
        case .getSearchingKeyword:
            return .GET
        }
    }
    var body: Data? {
        switch self {
        case .getSearchingKeyword:
            return nil
        }
    }
    func setURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getSearchingKeyword(let keyword):
            return "\(baseURL)/record/search?keyword=\(keyword)"
        }
    }
    
}
