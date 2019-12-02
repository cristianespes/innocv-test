//
//  Date+Extension.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 02/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

extension Date {
    func toServiceString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatter.string(from: self)
    }
}
