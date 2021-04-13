//
//  UserManager.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class UserManager {
    private let appClient: AppClient
    
    init(appClient: AppClient) {
        self.appClient = appClient
    }
}
