//
//  ShareService.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/21.
//

import Foundation

protocol ShareServiceable {
    func getSearchingKeyword(keyword: String) async throws -> [SearchResponse]?
}

struct ShareService: ShareServiceable {
    private let apiService: ShareRequestable
    private let environment: APIEnvironment
    
    init(apiService: ShareRequestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getSearchingKeyword(keyword: String) async throws -> [SearchResponse]? {
        let request = ShareEndPoint
            .getSearchingKeyword(keyword: keyword)
            .sendRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
