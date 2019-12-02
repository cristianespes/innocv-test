//
//  WebServices.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

final class WebServices: BaseServices {

    func getUsers(completion: @escaping (Error?, [User]?) -> Void) {
        let request = ApiEndpoint.getUsers.request(with: baseUrl)
        
        session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if  let error = error {
                    // TODO: Manejar los errores que lleguen
                    completion(error, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 || response.statusCode < 300 else {
                    completion(ApiError.unknown, nil)
                    return
                }
                
                guard let data = data else {
                    completion(ApiError.noData, nil)
                    return
                }
                
                do {
                    let response = try self.decoder.decode([User].self, from: data)
                    completion(nil, response)
                } catch let error as NSError {
                    completion(error, nil)
                }
            }
            
        }.resume()
    }
    
    func updateWith(user: User, completion: @escaping (Error?) -> Void) {
        let request = ApiEndpoint.updateUser.request(with: baseUrl, andBody: UserRequest(user: user))
                
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if  let error = error {
                    // TODO: Manejar los errores que lleguen
                    completion(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 || response.statusCode < 300 else {
                    completion(ApiError.unknown)
                    return
                }
                
                completion(nil)
            }
        }.resume()
    }
    
    func addTo(user: User, completion: @escaping (Error?) -> Void) {
        let request = ApiEndpoint.addUser.request(with: baseUrl, andBody: UserRequest(user: user))
                
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if  let error = error {
                    // TODO: Manejar los errores que lleguen
                    completion(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 || response.statusCode < 300 else {
                    completion(ApiError.unknown)
                    return
                }
                
                completion(nil)
            }
        }.resume()
    }
    
    func removeTo(userId: Int, completion: @escaping (Error?) -> Void) {
        let request = ApiEndpoint.removeUser(id: userId).request(with: baseUrl)
                
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if  let error = error {
                    // TODO: Manejar los errores que lleguen
                    completion(error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 || response.statusCode < 300 else {
                    completion(ApiError.unknown)
                    return
                }
                
                completion(nil)
            }
        }.resume()
    }
}
