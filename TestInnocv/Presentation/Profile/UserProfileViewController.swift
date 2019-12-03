//
//  UserProfileViewController.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

protocol UserProfileDelegate {
    func addedNewUser()
    func updatedUser()
}

final class UserProfileViewController: BaseViewController {
    
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
    
    var delegate: UserProfileDelegate? = nil
    
    static func newInstance(item: User? = nil, delegate: UserProfileDelegate? = nil) -> UserProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileViewController = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        userProfileViewController.presenter = UserProfilePresenterImpl(userProfileViewController, user: item)
        userProfileViewController.delegate = delegate
        
        return userProfileViewController
    }
    
    // MARK: IBAction
    @IBAction func buttonTapped(_ sender: UIButton) {
        if areFilledFields() {
            presenter.sendClicked(name: nameTextField.text!, birthdate: dateFormatter.date(from: dateTextField.text!)!)
        } else {
            showWarningAlert(message: "app.innocv.must_fill_red_fields".localized)
        }
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
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        
        dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone), dateInitial:
        birthdate, maximumDate: Date())
    }
    
    func showError(message: String) {
        showWarningAlert(message: message)
    }
    
    func navigateToBack() {
        if presenter.isNewUser {
            delegate?.addedNewUser()
            dismiss(animated: true, completion: nil)
        } else {
            delegate?.updatedUser()
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Private
private extension UserProfileViewController {
    func setupNavigationController() {
        title = "app.innocv.detail".localized
        
        if presenter.isNewUser {
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddNewUser))
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    @objc func cancelAddNewUser() {
        if !(nameTextField.text?.isEmpty ?? false) || !(dateTextField.text?.isEmpty ?? false) {
            let selectedStyle: UIAlertController.Style = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? .alert: .actionSheet
            
            let alertController = UIAlertController(title: "app.innocv.cancel_new_user_title".localized, message: "app.innocv.cancel_new_user_message".localized, preferredStyle: selectedStyle)
            alertController.addAction(UIAlertAction(title: "app.innocv.yes".localized, style: .default, handler: { _ in
                self.navigateToBack()
            }))
            alertController.addAction(UIAlertAction(title: "app.innocv.no".localized, style: .default, handler: nil))
            
            present(alertController, animated: true)
        } else{
            dismiss(animated: true, completion: nil)
        }
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
        
        if presenter.isNewUser {
            dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone), maximumDate: Date())
        }
        
        sendButton.setTitle(presenter.isNewUser ? "app.innocv.add".localized : "app.innocv.update".localized, for: .normal)
    }
    
    @objc func tapDone() {
        if let datePicker = dateTextField.inputView as? UIDatePicker {
            dateTextField.text = dateFormatter.string(from: datePicker.date)
        }
        
        dateTextField.resignFirstResponder() // 2-5
    }
    
    func areFilledFields() -> Bool {
        var isFilled = true
        
        if nameTextField.text?.isEmpty ?? true {
            isFilled = false
            nameLabel.textColor = .red
            
            nameTextField.layer.borderColor = UIColor.red.cgColor
            nameTextField.layer.borderWidth = 1.0
        } else {
            if #available(iOS 13.0, *) {
                nameLabel.textColor = .label
            } else {
                nameLabel.textColor = .black
            }
            
            nameTextField.layer.borderColor = UIColor.black.cgColor
            nameTextField.layer.borderWidth = 0
        }
        
        if dateTextField.text?.isEmpty ?? true {
            isFilled = false
            dateLabel.textColor = .red
            
            dateTextField.layer.borderColor = UIColor.red.cgColor
            dateTextField.layer.borderWidth = 1.0
        } else {
            if #available(iOS 13.0, *) {
                dateLabel.textColor = .label
            } else {
                dateLabel.textColor = .black
            }
            
            dateTextField.layer.borderColor = UIColor.black.cgColor
            dateTextField.layer.borderWidth = 0
        }
        
        return isFilled
    }
}
