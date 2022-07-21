//
//  APIManager.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol Requestable: AnyObject {
    func request(_ request: NetworkRequest) async throws -> [Record]
}

final class CreateAPIManager: Requestable {
    func request(_ request: NetworkRequest) async throws -> [Record] {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL)
        else { throw APIError.urlEncodingError }
        // 요청 보냄
        print(encodedURL)
        
        let (data, response) = try await URLSession.shared.data(for: request.createURLRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode
        else { throw APIError.serverError }

        let decodedData = try JSONDecoder().decode(Record.self, from: data)
        
        if decodedData.success {
            return [decodedData]
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
}
