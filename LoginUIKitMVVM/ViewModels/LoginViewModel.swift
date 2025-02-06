//
//  LoginViewModel.swift
//  LoginUIKitMVVM
//
//  Created by aljon antiola on 2/6/25.
//

import Foundation

class LoginViewModel {
    
    var username: String = ""
    var password: String = ""
    
    var onLoginSuccess: ((User) -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    // Basic validation for username and password
    func validateCredentials() -> Bool {
        guard !username.isEmpty, !password.isEmpty else {
            onLoginFailure?("Username and password cannot be empty.")
            return false
        }
        return true
    }
    
    func login() {
        
        guard validateCredentials() else { return }
        
        APIService.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.onLoginSuccess?(user)
                case .failure(let error):
                    self?.onLoginFailure?(error.localizedDescription)
                }
            }
        }
    }
}
