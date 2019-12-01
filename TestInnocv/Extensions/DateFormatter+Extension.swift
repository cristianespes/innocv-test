//
//  DateFormatter+Extension.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dateService: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
    
    func dateFromMultipleFormats(fromString dateString: String) -> Date? {
        let formats: [String] = [
        "yyyy-MM-dd",
        "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        "yyyy-MM-dd'T'HH:mm:ss'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSS",
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
        "yyyy-MM-dd HH:mm:ss"
        ]
        
        for format in formats {
            self.dateFormat = format
            if let date = self.date(from: dateString) {
                return date
            }
        }
        return nil
    }
}
