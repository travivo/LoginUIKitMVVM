//
//  APIService.swift
//  LoginUIKitMVVM
//
//  Created by aljon antiola on 2/6/25.
//

import Foundation

class APIService {
    
    static func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { // Simulate network delay
            if username == "user" && password == "password" {
                let user = User(username: username, token: "token123") // Simulate getting a session token after a successful sign in
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
            }
        }
    }
}
