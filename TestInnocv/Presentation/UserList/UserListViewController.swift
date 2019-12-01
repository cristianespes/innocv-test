//
//  UserListViewController.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    // MARK: IBoulets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchController : UISearchController!
    
    // MARK: Properties
    var presenter: UserListPresenter!
    
    static func newInstance() -> UserListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userListViewController = storyboard.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        userListViewController.presenter = UserListPresenterImpl(userListViewController)
        
        return userListViewController
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.initialize()
        presenter.update()
    }

}

extension UserListViewController: UserListView {
    func setupViews() {
        setupNavigationController()
        setupActivityIndicator()
        setupTableView()
        setupEmpty()
    }
    
    func showLoading() {
        emptyLabel.isHidden = true
        tableView.isHidden = true
        activityIndicator.isHidden = false
        
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
    }
    
    func stateData() {
        tableView.reloadData()
        
        emptyLabel.isHidden = true
        tableView.isHidden = false
    }
    
    func emptyData() {
        emptyLabel.isHidden = false
        tableView.isHidden = true
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive && !searchBarIsEmpty() {
            return presenter.searchResults.count
        } else {
            return presenter.getItemsNumber()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item: User
        
        if self.searchController.isActive && !searchBarIsEmpty() {
            item = presenter.searchResults[indexPath.row]
        } else {
            item = presenter.getItemsOnTableView()[indexPath.row]
        }
                
        return setupCell(item: item)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
                
        if self.searchController.isActive && !searchBarIsEmpty() {
            presenter.itemClicked(item: presenter.searchResults[indexPath.row])
        } else {
            presenter.itemClicked(item: presenter.getItemsOnTableView()[indexPath.row])
        }
    }
}

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.filterContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return self.searchController.searchBar.text?.isEmpty ?? true
    }
}

// MARK: Private
private extension UserListViewController {
    func setupNavigationController() {
        title = "app.innocv.users.users_title".localized
        
        searchController = UISearchController(searchResultsController: nil)
        setupSearchController(self,
                              searchController: searchController,
                              tableView: tableView,
                              placeholder: "app.innocv.users.users_searching_placeholder".localized)
    }
    
    func setupSearchController(_ vc: UISearchResultsUpdating, searchController: UISearchController, tableView: UITableView, placeholder: String) {
        let searchBar = searchController.searchBar
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchBar
        }
        
        definesPresentationContext = true
        searchController.searchResultsUpdater = vc
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = placeholder
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = UIColor.clear
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .gray
    }
    
    func setupEmpty() {
        emptyLabel.text = "app.innocv.users.users_empty".localized
        emptyLabel.textColor = .gray
        emptyLabel.textAlignment = .center
        emptyLabel.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func filterContentFor(textToSearch: String) {
        presenter.searchResults = presenter.getItemsOnTableView().filter({ (user) -> Bool in
            let nameToFind = user.name?.range(of: textToSearch, options: NSString.CompareOptions.caseInsensitive)

            return nameToFind != nil
        })
    }
    
    func setupCell(item: User) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.birthdate)"
        
        return cell
    }
}
