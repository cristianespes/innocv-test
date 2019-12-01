//
//  User.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: Int?
  var name: String?
  var birthdate: Date?
    
    init(from decoder: Decoder) throws {
        let dateFormatter = DateFormatter()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        birthdate = try dateFormatter.dateFromMultipleFormats(fromString: values.decodeIfPresent(String.self, forKey: .birthdate) ?? "")
    }
}

extension User {
    var proxyForEquality: String {
        return "\(id)\(name)"
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

extension User {
    var proxyForComparison: String {
        return "\(name)".lowercased()
    }
}

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
