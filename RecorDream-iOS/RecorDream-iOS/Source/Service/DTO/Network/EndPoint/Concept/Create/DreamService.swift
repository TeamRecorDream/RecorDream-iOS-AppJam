//
//  HomeService.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/21.
//

import Foundation
 
protocol HomeServiceable {
    func getRecorDreamCard() async throws -> [Record]
//    func postRecorDream() async throws -> DreamBaseModel
}

struct DreamService: HomeServiceable {
    
    private let apiService: CreateRequestable
    private let environment: APIEnvironment
    
    init(apiService: CreateRequestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getRecorDreamCard() async throws -> [Record] {
        let request = DreamEndPoint
            .getRecorDreamCard
            .sendRequest(environment: environment)
        print("request: \(request)")
        return try await self.apiService.request(request)
    }
    
//    func postRecorDream() async throws -> DreamBaseModel {
//        print("hello")
//    }
//
    
}
