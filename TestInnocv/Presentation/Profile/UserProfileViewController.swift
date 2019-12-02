//
//  UserProfileViewController.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

final class UserProfileViewController: UIViewController {
    
    // MARK: IBoulets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: Properties
    var presenter: UserProfilePresenter!
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        return dateFormatter
    }()

    static func newInstance(item: User? = nil) -> UserProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileViewController = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        userProfileViewController.presenter = UserProfilePresenterImpl(userProfileViewController, user: item)
        
        return userProfileViewController
    }
    
    // MARK: IBAction
    @IBAction func buttonTapped(_ sender: UIButton) {
        // TODO: AÑADIR COMPROBACION
        
        presenter.sendClicked(name: nameTextField.text!, birthdate: dateFormatter.date(from: dateTextField.text!)!)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.initialize()
    }

}

// MARK: UserProfileView
extension UserProfileViewController: UserProfileView {
    func setupViews() {
        setupNavigationController()
        setupActivityIndicator()
        setupData()
        
        scrollView.keyboardDismissMode = .onDrag
    }
    
    func showLoading() {
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
    
    func loadData(name: String, birthdate: Date?) {
        nameTextField.text = name
        
        if let birthdate = birthdate {
            dateTextField.text = dateFormatter.string(from: birthdate)
        } else {
            dateTextField.text = ""
        }
    }
    
    func navigateToBack() {
        if presenter.isNewUser {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Private
private extension UserProfileViewController {
    func setupNavigationController() {
        title = "app.innocv.users_title".localized
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .gray
    }
    
    func setupData() {
        nameLabel.text = "app.innocv.name".localized
        dateLabel.text = "app.innocv.birthday".localized
        nameTextField.placeholder = "app.innocv.introduce_name".localized
        dateTextField.placeholder = "app.innocv.introduce_birthday".localized
        
        sendButton.setTitle(presenter.isNewUser ? "app.innocv.add".localized : "app.innocv.update".localized, for: .normal)
    }
}
