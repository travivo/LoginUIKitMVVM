//
//  HomeViewController.swift
//  LoginUIKitMVVM
//
//  Created by aljon antiola on 2/6/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = currentUser {
            welcomeLabel.text = "Welcome, \(currentUser.username)!"
        }
    }
}
