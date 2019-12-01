//
//  UserListPresenterImpl.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

final class UserListPresenterImpl {
    
    let view: UserListView
    
    let webServices = AppDelegate.shared.webServices
    
    var users = [User]()
    var searchResults = [User]()
    
    init(_ view: UserListView) {
        self.view = view
    }
}

extension UserListPresenterImpl: UserListPresenter {
    
    func initialize() {
        self.view.setupViews()
    }
    
    func update() {
        self.view.showLoading()
        
        webServices.getUsers { [weak self] (error, users) in
            
            if let error = error {
                print("UserListPresenterImpl -> Error: \(error)")
                return
            }
                        
            guard let users = users, users.count > 0 else {
                self?.view.hideLoading()
                self?.view.emptyData()
                return
            }
            
            self?.users = users.filter { $0.name != nil }.sorted()
                 
            self?.view.hideLoading()
            self?.view.stateData()
        }
    }
    
    func getItemsOnTableView() -> [User] {
        return users
    }
    
    func getItemsNumber() -> Int {
        users.count
    }
    
    func getItemBy(_ index: Int) -> User {
        return users[index]
    }
    
    func itemClicked(item: User) {
        print("Patata -> user clicked: \(item)")
    }
}
