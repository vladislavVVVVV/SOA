//
//  AppClient.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import BrightFutures
import Alamofire

protocol AppClientProtocol {
    func login(email: String, password: String) -> Future<Token, NetworkRequestError>
    func register(username: String, email: String, password: String) -> Future<Token, NetworkRequestError>
    
    func getIngridient(id: Int) -> Future<Ingridient, NetworkRequestError>
    func getIngridients() -> Future<[Ingridient], NetworkRequestError>
    func editIngridient(id: Int, name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError>
    func createIngridient(name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError>
    func deleteIngridient(id: Int) -> Future<Void, NetworkRequestError>
    
    func getRecipesForMenue(by id: Int) -> Future<[Recipe], NetworkRequestError>
    func getRecipes() -> Future<[Recipe], NetworkRequestError>
    func editRecipe(with id: Int, name: String, description: String, idIngridients: [Int]) -> Future<Void, NetworkRequestError>
    func createRecipe(name: String, description: String, idIngridients: [Int]) -> Future<Void, NetworkRequestError>
    func deleteRecipe(with id: Int) -> Future<Void, NetworkRequestError>
    
    func getMenues() -> Future<[Menu], NetworkRequestError>
    func editMenue(with id: Int, name: String, idRecipes: [Int]) -> Future<Void, NetworkRequestError>
    func createMenue(name: String, idRecipes: [Int]) -> Future<Void, NetworkRequestError>
    func deleteMenue(with id: Int) -> Future<Void, NetworkRequestError>
}

final class AppClient: NetworkClient, AppClientProtocol {
    func getIngridient(id: Int) -> Future<Ingridient, NetworkRequestError> {
        return performRequest(route: AppRouter.getIngridient(id: id))
    }
    
    func register(username: String, email: String, password: String) -> Future<Token, NetworkRequestError> {
        return performRequest(route: AppRouter.registration(username: username, email: email, password: password))
    }
    
    func login(email: String, password: String) -> Future<Token, NetworkRequestError> {
        return performRequest(route: AppRouter.login(email: email, password: password))
    }
    
    func getRecipes() -> Future<[Recipe], NetworkRequestError> {
        return performRequest(route: AppRouter.getReciepes)
    }
    
    func getMenues() -> Future<[Menu], NetworkRequestError> {
        return performRequest(route: AppRouter.getMenues)
    }
    
    func editMenue(with id: Int, name: String, idRecipes: [Int]) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func createMenue(name: String, idRecipes: [Int]) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func deleteMenue(with id: Int) -> Future<Void, NetworkRequestError> {
        return performRequest(route: AppRouter.deleteMenu(id: id))
    }
    
    func editIngridient(id: Int, name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError> {
        return performRequest(route: AppRouter.editIngredient(id: id, request: IngridientRequest(name: name, proteins: proteins, carbohydrates: carbohydrates, fats: fats)))
    }
    
    func createIngridient(name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError> {
        return performRequest(route: AppRouter.createIngredient(request: IngridientRequest(name: name, proteins: proteins, carbohydrates: carbohydrates, fats: fats)))
    }
    
    func deleteIngridient(id: Int) -> Future<Void, NetworkRequestError> {
        return performRequest(route: AppRouter.deleteIngredient(id: id))
    }
    
    func getRecipesForMenue(by id: Int) -> Future<[Recipe], NetworkRequestError> {
        return performRequest(route: AppRouter.getReciepes)
    }
    
    func editRecipe(with id: Int, name: String, description: String, idIngridients: [Int]) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func createRecipe(name: String, description: String, idIngridients: [Int]) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func deleteRecipe(with id: Int) -> Future<Void, NetworkRequestError> {
        return performRequest(route: AppRouter.deleteRecipe(id: id))
    }
    
    func getIngridients() -> Future<[Ingridient], NetworkRequestError> {
        return performRequest(route: AppRouter.getIngridients)
    }
}
