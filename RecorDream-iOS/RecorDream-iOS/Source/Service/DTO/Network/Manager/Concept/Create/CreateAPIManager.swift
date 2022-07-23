//
//  APIManager.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import Foundation

protocol CreateRequestable: AnyObject {
    func request(_ request: NetworkRequest) async throws -> [Record]
//    func postRequest(record: CreateRecord) async throws -> DreamBaseModel
    func postRequest(record: CreateRecord, completionHandler: @escaping (Any) -> Void)
    func putRequset(record: PatchRecord, id: String)
}

final class CreateAPIManager: CreateRequestable {
    
    func request(_ request: NetworkRequest) async throws -> [Record] {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL)
        else { throw APIError.urlEncodingError }
        
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
    
//    func postRequest(record: CreateRecord) async throws -> DreamBaseModel {
//        let url = URL(string: "http://13.125.138.47:8000/record")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//
//        guard let uploadData = try? JSONEncoder().encode(record)
//            else { throw APIError.urlEncodingError }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("1", forHTTPHeaderField: "userId")
//
//        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
//            if let data = data,
//                let response = response as? HTTPURLResponse,
//               (200..<500) ~= response.statusCode {
//                print("response: \(response.statusCode)")
//
//                guard let responseData = try? JSONDecoder().decode(DreamBaseModel.self, from: data) else {
//                    print("json decode error")
//                    throw APIError.clientError(message: "client error")
//                }
//                if responseData.success {
//                    print(responseData.success)
//                    return [responseData]
//                } else {
//                    print("실패")
//                    throw APIError.clientError(message: decodedData.message)
//                }
//            } else {
//                print("Error")
//                throw APIError.clientError(message: decodedData.message)
//            }
//        }
//        task.resume()
//    }

    func postRequest(record: CreateRecord, completionHandler: @escaping (Any) -> Void) {
        let url = URL(string: "http://13.125.138.47:8000/record")
        print(url)
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
                print("response - post: \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(DreamBaseModel.self, from: data) else {
                    print("json decode error")
                    return
                }
                if responseData.success {
                    print(responseData.success)
                    completionHandler(responseData)
                } else {
                    print("실패")
                }
            } else {
                print("Error")
            }
        }
        task.resume()
    }
    
    func putRequset(record: PatchRecord, id: String) {
        let url = URL(string: "http://13.125.138.47:8000/record/62d7bc6f9669f53b6c72a8d7")
        var request = URLRequest(url: url!)
        request.httpMethod = "PATCH"
        
        guard let uploadData = try? JSONEncoder().encode(record)
            else { return }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        print("putRequset")
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let data = data,
                let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("response: \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(DreamBaseModel.self, from: data) else {
                    print("json decode error")
                    return
                }
                print("responseData: \(responseData)")
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
