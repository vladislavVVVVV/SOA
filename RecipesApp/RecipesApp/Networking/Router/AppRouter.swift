//
//  AppRouter.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import Alamofire

enum AppRouter: NetworkRouter {
    case login(email: String, password: String)
    case registration(username: String, email: String, password: String)
    
    case getIngridients
    case getIngridient(id: Int)
    case createIngredient(request: IngridientRequest)
    case editIngredient(id: Int, request: IngridientRequest)
    case deleteIngredient(id: Int)
    
    case getReciepes
    case getRecipe(id: Int)
    case createRecipe(request: RecipeRequest)
    case editRecipe(id: Int, request: RecipeRequest)
    case deleteRecipe(id: Int)
    
    case getMenues
    case getMenu(id: Int)
    case createMenu(request: MenuRequest)
    case editMenu(id: Int, request: MenuRequest)
    case deleteMenu(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getReciepes, .getIngridients, .getMenues, .getMenu, .getRecipe, .getIngridient:
            return .get
        case .createIngredient, .createMenu, .createRecipe:
            return .post
        case .deleteIngredient, .deleteMenu, .deleteRecipe, .login, .registration:
            return .delete
        case .editIngredient, .editMenu, .editRecipe:
            return .put
        }
    }

    var path: String {
        switch self {
        case .login:
            return Server.Production.baseURL + "/" + Server.PathComponent.api + "/" + Server.PathComponent.login
        case .registration:
            return Server.Production.baseURL + "/" + Server.PathComponent.api + "/" + Server.PathComponent.register
        case .getIngridients:
            return Server.Production.baseURL + "/" + Server.PathComponent.ingredient
        case .getIngridient(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.ingredient + "/" + "\(id)"
        case .createIngredient:
            return Server.Production.baseURL + "/" + Server.PathComponent.ingredient
        case .editIngredient(id: let id, request: _):
            return Server.Production.baseURL + "/" + Server.PathComponent.ingredient + "/" + "\(id)"
        case .deleteIngredient(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.ingredient + "/" + "\(id)"
        case .getReciepes:
            return Server.Production.baseURL + "/" + Server.PathComponent.recipes
        case .getRecipe(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.recipes + "/" + "\(id)"
        case .createRecipe:
            return Server.Production.baseURL + "/" + Server.PathComponent.recipes
        case .editRecipe(id: let id, request: _):
            return Server.Production.baseURL + "/" + Server.PathComponent.recipes + "/" + "\(id)"
        case .deleteRecipe(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.recipes + "/" + "\(id)"
        case .getMenues:
            return Server.Production.baseURL + "/" + Server.PathComponent.menues
        case .getMenu(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.menues + "/" + "\(id)"
        case .createMenu:
            return Server.Production.baseURL + "/" + Server.PathComponent.menues
        case .editMenu(id: let id, request: _):
            return Server.Production.baseURL + "/" + Server.PathComponent.menues + "/" + "\(id)"
        case .deleteMenu(id: let id):
            return Server.Production.baseURL + "/" + Server.PathComponent.menues + "/" + "\(id)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return ["email": email,
                    "password": password]
        case .registration(let username, let email, let password):
            return ["username": username,
                    "email": email,
                    "password": password]
        default:
            return nil
        }
    }
}
