//
//  ApiEndpoint.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

enum RequestType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum ApiEndpoint {
    case getUsers
    case addUser
    case updateUser
    case removeUser(id: Int)
    case getUser(id: Int)
    
    static let baseURL = "https://hello-world.innocv.com/api/"
}

extension ApiEndpoint {
    var method: RequestType {
        switch self {
        case .getUsers:
            return .GET
        case .addUser:
            return .PUT
        case .updateUser:
            return .POST
        case .removeUser:
            return .DELETE
        case .getUser:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .removeUser(let id), .getUser(let id):
            return "User/\(id)"
        default:
            return "User"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
}

extension ApiEndpoint {
    func request<T: Encodable>(with baseURL: URL, andBody body: T) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        let data = try! JSONEncoder().encode(body)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the expected response is also JSON
        request.httpMethod = method.rawValue
        request.httpBody = data
        
        return request
    }
    
    func request(with baseURL: URL, adding parameters: [String: String] = [:]) -> URLRequest {
        let url = buildUrl(with: baseURL, adding: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        print(request.url!)
        
        return request
    }
    
    func buildUrl(with baseURL: URL, adding parameters: [String: String] = [:]) -> URL {
        let url = baseURL.appendingPathComponent(path)
        
        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)
        
        let request = URLRequest(url: components.url!)
        
        return request.url!
    }
}
