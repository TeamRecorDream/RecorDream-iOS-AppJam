//
//  ShareAPIManager.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/22.
//

import Foundation

protocol ShareRequestable: AnyObject {
    func request(_ request: NetworkRequest) async throws -> [SearchResponse]
}

final class ShareAPIManager: ShareRequestable {
    func request(_ request: NetworkRequest) async throws -> [SearchResponse] {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL)
        else { throw APIError.urlEncodingError }
        
        let (data, response) = try await URLSession.shared.data(for: request.createURLRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode
        else { throw APIError.serverError }

        let decodedData = try JSONDecoder().decode(SearchResponse.self, from: data)
        
        if decodedData.success {
            return [decodedData]
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
}
