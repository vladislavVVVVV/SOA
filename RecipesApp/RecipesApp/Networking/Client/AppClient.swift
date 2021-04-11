//
//  AppClient.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import BrightFutures
import Alamofire

protocol AppClientProtocol {
    func getIngridients() -> Future<[Ingridient], NetworkRequestError>
    func editIngridient(id: Int, name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError>
    func createIngridient(name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError>
    func deleteIngridient(id: Int) -> Future<Void, NetworkRequestError>
    
    func getRecipes() -> Future<[Ingridient], NetworkRequestError>
    func editRecipe() -> Future<Void, NetworkRequestError>
    func createRecipe() -> Future<Void, NetworkRequestError>
    func deleteRecipe() -> Future<Void, NetworkRequestError>
    
    func getMenues() -> Future<[Ingridient], NetworkRequestError>
    func editMenue() -> Future<Void, NetworkRequestError>
    func createMenue() -> Future<Void, NetworkRequestError>
    func deleteMenue() -> Future<Void, NetworkRequestError>
}

final class AppClient: NetworkClient, AppClientProtocol {
    func getMenues() -> Future<[Ingridient], NetworkRequestError> {
        return Future { complition in
            complition(.success([]))
        }
    }
    
    func editMenue() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func createMenue() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func deleteMenue() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func editIngridient(id: Int, name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func createIngridient(name: String, fats: Int, proteins: Int, carbohydrates: Int) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func deleteIngridient(id: Int) -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func getRecipes() -> Future<[Ingridient], NetworkRequestError> {
        return Future { complition in
            complition(.success([]))
        }
    }
    
    func editRecipe() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func createRecipe() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func deleteRecipe() -> Future<Void, NetworkRequestError> {
        return Future { complition in
            complition(.success(Void()))
        }
    }
    
    func getIngridients() -> Future<[Ingridient], NetworkRequestError> {
        //return performRequest(route: AppRouter.getNews(category: category))
        return Future { complition in
            complition(.success([Ingridient(id: 1, name: "Мясо", proteins: 20, carbohydrates: 2, fats: 50), Ingridient(id: 2, name: "Банан", proteins: 100, carbohydrates: 2, fats: 20), Ingridient(id: 3, name: "Гуава", proteins: 2, carbohydrates: 3, fats: 50)]))
        }
    }
}
