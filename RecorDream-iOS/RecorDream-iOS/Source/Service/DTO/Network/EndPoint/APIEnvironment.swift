//
//  APIEnvironment.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

// 추후 숨길 폴더(파일)

enum APIEnvironment: String {
    case mock
    case development
    case production
}

extension APIEnvironment {
    var baseURL: String {
        switch self {
        case .mock:
            return ""
        case .development:
            return "http://13.125.138.47:8000"
        case .production:
            return ""
        }
    }
    
    static var token: String {
        return ""   // TODO: - 실행 시 토큰 넣어주기
    }
}
