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
    
}
