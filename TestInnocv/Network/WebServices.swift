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
        
        session.dataTask(with: request) { data, _, error in
            
            DispatchQueue.main.async {
                if  let error = error {
                    completion(error, nil)
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
}
