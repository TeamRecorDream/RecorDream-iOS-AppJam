//
//  APIManager.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol CreateRequestable: AnyObject {
    func request(_ request: NetworkRequest) async throws -> [Record]
    func postRequest(record: CreateRecord)
}

final class CreateAPIManager: CreateRequestable {
    
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
        print("httpResponse.statusCode: \(httpResponse.statusCode)")

        print("decodedData")
        let decodedData = try JSONDecoder().decode(Record.self, from: data)
        print("decodedData: \(decodedData)")
        
        if decodedData.success {
            return [decodedData]
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
    
    func postRequest(record: CreateRecord) {
//        let test = CreateRecord(title: "오늘은 7월 20일", date: Date(), content: "살려줘", emotion: 2, dreamColor: 3, genre: [2], note: "hi", voice: "62cdb868c3032f2b7af76531", writer: "62c9cf068094605c781a2fb9")
//
        let url = URL(string: "http://13.125.138.47:8000/record")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        guard let uploadData = try? JSONEncoder().encode(record)
            else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            
            if let data = data,
                let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("response: \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(DreamBaseModel.self, from: data) else {
                    print("json decode error")
                    return
                }
                if responseData.success {
                    print(responseData.success)
                } else {
                    print("실패")
                }
            } else {
                print("Error")
            }
        }
        task.resume()
    }
    
}
