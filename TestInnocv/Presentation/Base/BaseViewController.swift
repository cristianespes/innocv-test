//
//  BaseViewController.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 03/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        return dateFormatter
    }()
    
    func showWarningAlert(message: String? = nil) {
        let alertController = UIAlertController(title: "app.innocv.warning".localized, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "app.innocv.accept".localized, style: .default, handler: nil))
        
        present(alertController, animated: true)
    }
}
