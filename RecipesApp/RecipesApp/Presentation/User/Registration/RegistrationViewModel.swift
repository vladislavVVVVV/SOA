//
//  RegistrationViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class RegistrationViewModel {
    let userManager: UserManager
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func registerUser(username: String, email: String, password: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        userManager.requsterUser(username: username, email: email, password: password) {
            success()
        } failure: { (error) in
            failure(error)
        }
    }
}
