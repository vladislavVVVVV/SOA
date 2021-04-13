//
//  ChooseRecipeViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation
import BrightFutures

final class ChooseRecipeViewModel {

    private let appClient: AppClientProtocol
    var menu: Menu?
    var recipes = [Recipe]()

    init(appClient: AppClientProtocol, menu: Menu?) {
        self.appClient = appClient
        self.menu = menu
    }

    func getRecipes(success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getRecipes().onSuccess { [weak self] (recipes) in
            guard let self = self else { return }
            self.recipes = recipes
            success()
        }
    }
    
    func deleteRecipe(id: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.deleteRecipe(with: id).onSuccess { () in
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
    
    func isSelectedRecipes(indexPath: Int) -> Bool {
        guard let menu = menu, let recipes = menu.recipes else {
            return false
        }
        var isContain = false
        for recipe in recipes {
            if self.recipes[indexPath].recipeId == recipe.recipeId {
                isContain = true
            }
        }
        return isContain
    }
}
