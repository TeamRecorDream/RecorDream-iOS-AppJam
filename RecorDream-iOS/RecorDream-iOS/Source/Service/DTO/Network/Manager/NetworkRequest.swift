//
//  NetworkRequest.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

struct NetworkRequest {
    let url: String
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [String: String]?
    
    init(url: String,
         httpMethod: HTTPMethod,
         requestBody: Data? = nil,
         headers: [String: String]? = nil
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = requestBody
        self.headers = headers
    }
    
    func createURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        
        return urlRequest
    }
}
