//
//  UserProfileViewController.swift
//  TestInnocv
//
//  Created by CRISTIAN ESPES on 01/12/2019.
//  Copyright © 2019 Cristian Espes. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: IBoulets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: Properties
    
    

    static func newInstance(item: User? = nil) -> UserProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileViewController = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        
        return userProfileViewController
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Patata -> Button tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.keyboardDismissMode = .onDrag
    }

}
