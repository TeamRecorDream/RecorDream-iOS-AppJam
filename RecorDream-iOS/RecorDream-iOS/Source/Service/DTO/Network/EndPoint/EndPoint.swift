//
//  EndPoint.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol EndPoint {
    var method: HTTPMethod { get }
    var body: Data? { get }
    
    func setURL(from environment: APIEnvironment) -> String
    func sendRequest(environment: APIEnvironment) -> NetworkRequest
}

extension EndPoint {
    func sendRequest(environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["userId"] = "1"
        
        return NetworkRequest(url: setURL(from: environment),
                              httpMethod: method,
                              requestBody: body,
                              headers: headers)
    }
}
