//
//  UserProfilePresenterImpl.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 02/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

final class UserProfilePresenterImpl {
    
    let view: UserProfileView
    
    let webServices = AppDelegate.shared.webServices
    
    var user: User? = nil
    var searchResults = [User]()
    
    init(_ view: UserProfileView, user: User? = nil) {
        self.view = view
        self.user = user
    }
}

extension UserProfilePresenterImpl: UserProfilePresenter {

    func initialize() {
        self.view.setupViews()
        self.view.hideLoading()
        
        if !isNewUser, let user = user, let name = user.name {
            self.view.loadData(name: name, birthdate: user.birthdate)
        }
    }
    
    var isNewUser: Bool {
        return self.user == nil
    }
    
    func getBirthday() -> Date? {
        if isNewUser, let birthday = user?.birthdate {
            return birthday
        }
        
        return nil
    }
    
    func sendClicked(name: String, birthdate: Date) {
        self.user?.name = name
        self.user?.birthdate = birthdate
        
        if !isNewUser, let user = user {
            update(user)
        } else {
            let user = User(name: name, birthdate: birthdate)
            add(user)
        }
    }
    
}

private extension UserProfilePresenterImpl {
    func update(_ user: User) {
        self.view.showLoading()
        
        webServices.updateWith(user: user) { [weak self] (error) in
            if let error = error {
                print("Error: \(error)")
                self?.view.showError(message: "app.innocv.there_was_error".localized)
                return
            }
                             
            self?.view.hideLoading()
            self?.view.navigateToBack()
        }
    }
    
    func add(_ user: User) {
        self.view.showLoading()
        
        webServices.addTo(user: user) { [weak self] (error) in
            if let error = error {
                print("Error: \(error)")
                self?.view.showError(message: "app.innocv.there_was_error".localized)
                return
            }
                    
            self?.view.hideLoading()
            self?.view.navigateToBack()
        }
    }
}
