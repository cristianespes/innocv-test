//
//  UITextField+Extension.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 03/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector, dateInitial: Date? = nil, maximumDate: Date? = nil) {

        let screenWidth = UIScreen.main.bounds.width
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        
        if let dateInitial = dateInitial {
            datePicker.date = dateInitial
        }
        
        if let maximumDate = maximumDate {
          datePicker.maximumDate = maximumDate
        }
        
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "app.innocv.cancel".localized, style: .plain, target: nil, action: #selector(tapCancel))
        
        let barButton = UIBarButtonItem(title: "app.innocv.done".localized, style: .plain, target: target, action: selector)
        
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
