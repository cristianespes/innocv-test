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
                print("Error: \(error)")
                self?.view.showError(message: "app.innocv.there_was_error".localized)
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
        view.navigateToProfile(item: item)
    }
    
    func addItemClicked() {
        view.navigateToAddUser()
    }
    
    func itemDeleted(index: Int, item: User) {
        delete(item) { isSuccess in
            if isSuccess {
                self.searchResults = self.searchResults.filter { $0 != item }
                self.users = self.users.filter { $0 != item }
                self.view.deleteItem(index: index)
            } else {
                self.view.showError(message: "app.innocv.there_was_error".localized)
            }
        }
    }
}

private extension UserListPresenterImpl {
    func delete(_ user: User, completion: @escaping (Bool) -> Void) {
        self.view.showLoading()
        
        guard let userId = user.id else {
            self.view.hideLoading()
            self.view.stateData()
            completion(false)
            return
        }
        
        webServices.removeTo(userId: userId) { [weak self] (error) in
            
            if let error = error {
                print("Error: \(error)")
                self?.view.showError(message: "app.innocv.there_was_error".localized)
                return
            }
                             
            self?.view.hideLoading()
            self?.view.stateData()
            completion(true)
        }
    }
}
