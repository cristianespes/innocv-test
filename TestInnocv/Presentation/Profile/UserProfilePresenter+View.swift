//
//  UserProfilePresenter+View.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 02/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

protocol UserProfilePresenter: BasePresenter {
    var isNewUser: Bool { get }
    
    func getBirthday() -> Date?
    
    func sendClicked(name: String, birthdate: Date)
}

protocol UserProfileView {
    func setupViews()
    func showLoading()
    func hideLoading()
    
    func loadData(name: String, birthdate: Date?)
    func navigateToBack()
}
