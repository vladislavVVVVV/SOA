//
//  RecipeViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

final class RecipeViewModel {
    let selectedRecipe: Recipe
    let appClient: AppClientProtocol
    
    init(recipe: Recipe, appClient: AppClientProtocol) {
        self.selectedRecipe = recipe
        self.appClient = appClient
    }
}
