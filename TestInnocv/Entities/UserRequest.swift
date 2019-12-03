//
//  UserRequest.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 02/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

struct UserRequest: Encodable {
  let id: Int?
  let name: String?
  let birthdate: String?
    
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.birthdate = user.birthdate?.toServiceString()
    }
}
