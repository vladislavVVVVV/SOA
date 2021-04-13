//
//  UserManager.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class UserManager {
    private let appClient: AppClientProtocol
    
    init(appClient: AppClientProtocol) {
        self.appClient = appClient
    }
    
    func loginUser(email: String, password: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.login(email: email, password: password).onSuccess { (token) in
            guard let token = token.token else {
                failure(.unknownError)
                return
            }
            KeychainManager.shared.connectToken = ConnectToken(accessToken: token, ifv: nil)
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
    
    func requsterUser(username: String, email: String, password: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.register(username: username, email: email, password: password).onSuccess { (token) in
            guard let token = token.token else {
                failure(.unknownError)
                return
            }
            KeychainManager.shared.connectToken = ConnectToken(accessToken: token, ifv: nil)
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }

    func logout() {
        KeychainManager.shared.connectToken = ConnectToken(accessToken: "", ifv: nil)
    }
}
