//
//  UserListPresenter+View.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import Foundation

protocol UserListPresenter: BasePresenter {
    var searchResults: [User] { get set }
    
    func getItemsOnTableView() -> [User]
    func getItemsNumber() -> Int
    func getItemBy(_ index: Int) -> User
    
    func itemClicked(item: User)
    func addItemClicked()
}

protocol UserListView {
    func setupViews()
    func showLoading()
    func hideLoading()
    func stateData()
    func emptyData()
    func navigateToProfile(item: User)
}
