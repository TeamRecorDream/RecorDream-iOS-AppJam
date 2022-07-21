//
//  APIManager.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol Requestable: AnyObject {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}

final class APIManager: Requestable {
    func request<T>(_ request: NetworkRequest) async throws -> T? where T : Decodable {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL)
        else { throw APIError.urlEncodingError }
        
        let (data, response) = try await URLSession.shared.data(for: request.createURLRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode
        else { throw APIError.serverError }
        
        let decodedData = try JSONDecoder().decode(BaseModel<T>.self, from: data)
        if decodedData.success {
            return decodedData.data
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
}
