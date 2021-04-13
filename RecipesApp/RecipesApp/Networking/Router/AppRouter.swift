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
        case .createIngredient, .createMenu, .createRecipe, .login, .registration:
            return .post
        case .deleteIngredient, .deleteMenu, .deleteRecipe:
            return .delete
        case .editIngredient, .editMenu, .editRecipe:
            return .put
        }
    }

    var path: String {
        switch self {
        case .login:
            return  Server.PathComponent.api + "/" + Server.PathComponent.auth + "/" + Server.PathComponent.login
        case .registration:
            return Server.PathComponent.api + "/" + Server.PathComponent.auth + "/" + Server.PathComponent.register
        case .getIngridients:
            return Server.PathComponent.ingredient
        case .getIngridient(id: let id):
            return Server.PathComponent.ingredient + "/" + "\(id)"
        case .createIngredient:
            return Server.PathComponent.ingredient
        case .editIngredient(id: let id, request: _):
            return Server.PathComponent.ingredient + "/" + "\(id)"
        case .deleteIngredient(id: let id):
            return Server.PathComponent.ingredient + "/" + "\(id)"
        case .getReciepes:
            return Server.PathComponent.recipes
        case .getRecipe(id: let id):
            return Server.PathComponent.recipes + "/" + "\(id)"
        case .createRecipe:
            return Server.PathComponent.recipes
        case .editRecipe(id: let id, request: _):
            return Server.PathComponent.recipes + "/" + "\(id)"
        case .deleteRecipe(id: let id):
            return Server.PathComponent.recipes + "/" + "\(id)"
        case .getMenues:
            return Server.PathComponent.menues
        case .getMenu(id: let id):
            return Server.PathComponent.menues + "/" + "\(id)"
        case .createMenu:
            return Server.PathComponent.menues
        case .editMenu(id: let id, request: _):
            return Server.PathComponent.menues + "/" + "\(id)"
        case .deleteMenu(id: let id):
            return Server.PathComponent.menues + "/" + "\(id)"
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
        case .createIngredient(let request):
            return ["name": request.name,
                    "proteins": request.proteins,
                    "carbohydrates": request.carbohydrates,
                    "fats": request.fats]
        case .editIngredient(let id, let request):
            return ["ingredientId": id,
                    "name": request.name,
                    "proteins": request.proteins,
                    "carbohydrates": request.carbohydrates,
                    "fats": request.fats]
        case .createRecipe(let request):
            return ["name": request.name,
                    "ingredients": request.ingridients]
        case .editRecipe(let id, let request):
            return ["recipeId": id,
                    "name": request.name,
                    "ingredients": request.ingridients]
        case .createMenu(let request):
            return request.dictionary
        case .editMenu(_ , let request):
            return request.dictionary
//            return ["menueId": id,
//                    "name": request.name,
//                    "recipes": request.recipes]
        default:
            return nil
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
