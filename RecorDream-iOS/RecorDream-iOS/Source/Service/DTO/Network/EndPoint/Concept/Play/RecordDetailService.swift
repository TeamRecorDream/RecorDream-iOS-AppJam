//
//  RecordDetailService.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/22.
//

import Foundation

class RecordDetailService {
    static let shared = RecordDetailService()
    
    func getRecordDetial(recordID: String, completionHandler: @escaping (Any) -> Void) {
        let url = URL(string: "http://13.125.138.47:8000/record/\(recordID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response StatusCode : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<RecordDetailModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                    let status = responseData.status
                    guard let value = responseData.data else { return }
                    completionHandler(value)
                } else {
                    print("Error: ResponseData Fail")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
    
    func deleteRecord(recordID: String, completionHandler: @escaping (Any) -> Void) {
        let url = URL(string: "http://13.125.138.47:8000/record/\(recordID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response StatusCode : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<RecordDetailModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                    guard let value = responseData.data else { return }
                    completionHandler(value)
                } else {
                    print("Error: ResponseData Fail")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
}
