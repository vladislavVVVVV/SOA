//
//  CreateEditMenuViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

enum MenuState: Equatable {
    case create
    case edit(menu: Menu)
}

final class CreateEditMenuViewModel {
    let appClient: AppClientProtocol
    let state: MenuState
    var selectedRecipes: [Recipe]
    
    init(appClient: AppClientProtocol, state: MenuState) {
        self.state = state
        self.appClient = appClient
        switch state {
        case .create:
            selectedRecipes = []
        case .edit(let menu):
            selectedRecipes = menu.recipes ?? []
        }
    }
    
    func createEditMenu(name: String, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        switch state {
        case .create:
            var igrs: [RecipeRequest] = []
            selectedRecipes.forEach { (ing) in
                igrs.append(RecipeRequest(recipe: ing))
            }
            appClient.createMenue(request: MenuRequest(menueId: 0, name: name, recipes: igrs)).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        case .edit(let menu):
            var igrs: [RecipeRequest] = []
            selectedRecipes.forEach { (ing) in
                igrs.append(RecipeRequest(recipe: ing))
            }
            appClient.editMenue(with: menu.menueId ?? 0, request: MenuRequest(menueId: menu.menueId ?? 0, name: name, recipes: igrs)).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        }
    }
}
