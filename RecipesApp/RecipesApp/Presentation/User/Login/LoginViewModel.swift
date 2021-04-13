//
//  LoginViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class LoginViewModel {
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func loginUser(email: String, password: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        userManager.loginUser(email: email, password: password) {
            success()
        } failure: { (error) in
            failure(error)
        }
    }
}
