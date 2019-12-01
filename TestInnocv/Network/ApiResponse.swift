//
//  ApiResponse.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

final class ApiArrayResponse<T: Codable>: Codable {
    var resources : [T]?

    enum CodingKeys: String, CodingKey {
        case resources
    }
}

final class ApiResponse<T: Codable>: Codable {
    var resources : T?
    
    enum CodingKeys: String, CodingKey {
        case resources
    }
}
