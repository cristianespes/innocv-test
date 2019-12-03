//
//  String+Extension.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return self.localized()
    }
    
    private func localized(comment: String = "") -> String {
        var result = NSLocalizedString(self, tableName: "CustomLocalizable", bundle: Bundle.main, value: self, comment: comment)
        
        if result == self {
            result = NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: comment)
        }
        
        return result
    }
}
