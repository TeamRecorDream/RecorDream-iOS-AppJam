//
//  APIManager.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol Requestable: AnyObject {
//    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
    func request(_ request: NetworkRequest) async throws -> [Record]
}

final class APIManager: Requestable {
//    func request<T>(_ request: NetworkRequest) async throws -> T? where T : Decodable {
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
        // 걸렀음
//
//        let httpResponse = response as? HTTPURLResponse
//
//        if let jsonResponse = String(data: data, encoding: String.Encoding.utf8) {
//            print("JSON String: (\(jsonResponse)")
//        }
        
        let decodedData = try JSONDecoder().decode(Record.self, from: data)
        
//        print("plz")
        print(decodedData)
        
        if decodedData.success {
//            print(decodedData.data)
            return [decodedData]
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
}
