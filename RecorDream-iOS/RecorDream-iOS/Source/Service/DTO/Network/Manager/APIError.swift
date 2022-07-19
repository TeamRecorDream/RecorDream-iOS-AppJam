//
//  APIError.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

enum APIError: Error {
    case urlEncodingError
    case clientError(message: String?)
    case serverError
}
