//
//  CreateEditRecipeViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

enum RecipeState: Equatable {
    case create
    case edit(recipe: Recipe)
}

final class CreateEditRecipeViewModel {
    let appClient: AppClientProtocol
    let state: RecipeState
    var choosedIngridients: [Ingridient]
    
    init(appClient: AppClientProtocol, state: RecipeState) {
        self.state = state
        self.appClient = appClient
        switch self.state {
        case .edit(let recipe):
            choosedIngridients = recipe.ingredients ?? []
        default:
            choosedIngridients = []
        }
    }
    
    func createEditRecipe(name: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        switch state {
        case .create:
            var igrs: [IngridientRequest] = []
            choosedIngridients.forEach { (ing) in
                igrs.append(IngridientRequest(ingridient: ing))
            }
            appClient.createRecipe(name: name, ingridients: igrs).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        case .edit(let recipe):
            var igrs: [IngridientRequest] = []
            choosedIngridients.forEach { (ing) in
                igrs.append(IngridientRequest(ingridient: ing))
            }
            appClient.editRecipe(with: recipe.recipeId ?? 0, request: RecipeRequest(recipeId: recipe.recipeId ?? 0, name: name, ingridients: igrs)).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        }
    }
}
