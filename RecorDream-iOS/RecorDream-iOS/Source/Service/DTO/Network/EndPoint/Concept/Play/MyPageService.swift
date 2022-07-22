//
//  MyPageService.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/21.
//

import Foundation

class MyPageService {
    static let shared = MyPageService()
    
    func getUserInformation(completionHandler: @escaping (Any) -> Void) {
        let token = APIEnvironment.token
        let url = URL(string: "http://13.125.138.47:8000/user/\(token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response StatusCode : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<UserInformationModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                    let status = responseData.status
                    guard let value = responseData.data else { return }
                    completionHandler(value)
                } else {
                    print("Error: JSON data parsing failed")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
    
    func putUserNickname(nickname: String) {
        let url = URL(string: "http://13.125.138.47:8000/user/nickname")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let parameters = ["nickname": nickname]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response Status : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<UserInformationModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                }else {
                    print("Error: JSON data parsing failed")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
    
    func PutUserToggle(isOn: Bool) {
        let value = isOn ? "1" : "0"
        
        let url = URL(string: "http://13.125.138.47:8000/user/\(value)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let parameters = ["fcm_token": APIEnvironment.token]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response Status : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<UserInformationModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                }else {
                    print("Error: JSON data parsing failed")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
    
    func postNotice(time: String) {
        let url = URL(string: "http://13.125.138.47:8000/notice")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let parameters = ["fcm_token": APIEnvironment.token, "time" : time]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response Status : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<NoticeModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                } else {
                    print("Error: JSON data parsing failed")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
    
    func putNotice(time: String) {
        let url = URL(string: "http://13.125.138.47:8000/notice")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "userId")
        
        let parameters = ["fcm_token": APIEnvironment.token, "time" : time]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               (200..<500) ~= response.statusCode {
                print("Response Status : \(response.statusCode)")
                
                guard let responseData = try? JSONDecoder().decode(BaseModel<NoticeModel>.self, from: data) else {
                    print("Error: JSON data parsing failed")
                    return
                }
                if responseData.success {
                } else {
                    print("Error: JSON data parsing failed")
                }
            } else {
                print("Error: HTTP request failed")
            }
        }
        task.resume()
    }
}
