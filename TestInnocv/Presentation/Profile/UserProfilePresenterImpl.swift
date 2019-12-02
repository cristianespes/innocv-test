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
    
    func sendClicked(name: String, birthdate: Date) {
        self.view.showLoading()
        
        self.user?.name = name
        self.user?.birthdate = birthdate
        
        if !isNewUser, let user = user {
            update(user)
        } else {
           // TODO: IMPLEMENTAR AÑADIR USUARIO
        }
    }
    
}

private extension UserProfilePresenterImpl {
    func update(_ user: User) {
        self.view.showLoading()
        
        webServices.updateWith(user: user) { [weak self] (error) in
            
            if let error = error {
                print("UserListPresenterImpl -> Error: \(error)")
                return
            }
                             
            self?.view.hideLoading()
            
            // TODO: MOSTAR MENSAJE TODO OK Y FINALIZAR VISTA NAVEGANDO HACIA ATRAS
            self?.view.navigateToBack()
        }
    }
}
