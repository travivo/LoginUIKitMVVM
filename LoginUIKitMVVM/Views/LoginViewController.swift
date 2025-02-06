//
//  LoginViewController.swift
//  LoginUIKitMVVM
//
//  Created by aljon antiola on 2/6/25.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: CustomButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        setupViewModel()
        setupDoneToolbar()
    }
    
    func setupDoneToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([doneButton], animated: false)
        
        usernameTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }

    
    private func setupViewModel() {
        viewModel.onLoginSuccess = { [weak self] user in
            DispatchQueue.main.async {
                self?.signInButton.stopSpinning()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    homeVC.currentUser = user
                    homeVC.modalPresentationStyle = .fullScreen
                    self?.present(homeVC, animated: true)
                }
                
                self?.errorLabel.isHidden = true
            }
        }
        
        viewModel.onLoginFailure = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.signInButton.stopSpinning()
                self?.errorLabel.text = errorMessage
                self?.errorLabel.isHidden = false
                self?.usernameTextField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func didTapSignin(_ sender: UIButton) {
        signInButton.startSpinning()
        viewModel.username = usernameTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.login()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
