//
//  RecipesViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation
import BrightFutures

final class RecipesViewModel {

    private let appClient: AppClientProtocol
    private let userManager: UserManager
    var recepies = [Recipe]()

    init(appClient: AppClientProtocol, userManager: UserManager) {
        self.appClient = appClient
        self.userManager = userManager
    }

    func getRecipes(success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getRecipes().onSuccess { [weak self] (recipes) in
            guard let self = self else { return }
            self.recepies = recipes
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
    
    func deleteRecipe(id: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.deleteRecipe(with: id).onSuccess { () in
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
    
    func logout(complition: () -> Void) {
        userManager.logout()
        complition()
    }
}
