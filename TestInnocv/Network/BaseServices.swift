//
//  BaseServices.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

class BaseServices {
    let baseUrl = URL(string: ApiEndpoint.baseURL)!
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    init() {
        self.decoder.dateDecodingStrategy = .formatted(DateFormatter.dateService)
    }
}
