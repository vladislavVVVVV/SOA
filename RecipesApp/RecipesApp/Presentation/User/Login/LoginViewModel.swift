//
//  LoginViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class LoginViewModel {
    let appClient: AppClientProtocol
    
    init(appClient: AppClientProtocol) {
        self.appClient = appClient
    }
}
