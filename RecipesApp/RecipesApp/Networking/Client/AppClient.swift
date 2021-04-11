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
    func getRecipes() -> Future<[Recipe], NetworkRequestError> {
        return Future { complition in
            complition(.success([Recipe(id: 1, name: "Рулька", description: "Готовим быстро и вкусно", ingridients: [Ingridient(id: 1, name: "Свинина", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 2, name: "Пиво", proteins: 10, carbohydrates: 23, fats: 140)]), Recipe(id: 2, name: "Пуддинг", description: "Готовим медленно и не вкусно", ingridients: [Ingridient(id: 3, name: "Шоколад", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 4, name: "Молоко", proteins: 10, carbohydrates: 23, fats: 140)])]))
        }
    }
    
    func getMenues() -> Future<[Menu], NetworkRequestError> {
        return Future { complition in
            complition(.success([Menu(id: 1, name: "Первое меню", recipes: [Recipe(id: 1, name: "Рулька", description: "Готовим быстро и вкусно!", ingridients: [Ingridient(id: 1, name: "Свинина", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 2, name: "Пиво", proteins: 10, carbohydrates: 23, fats: 140)]), Recipe(id: 2, name: "Пуддинг", description: "Готовим медленно и не вкусно", ingridients: [Ingridient(id: 3, name: "Шоколад", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 4, name: "Молоко", proteins: 10, carbohydrates: 23, fats: 140)])])]))
        }
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
    
    func getRecipesForMenue(by id: Int) -> Future<[Recipe], NetworkRequestError> {
        return Future { complition in
            complition(.success([Recipe(id: 1, name: "Рулька", description: "Готовим быстро и вкусно", ingridients: [Ingridient(id: 1, name: "Свинина", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 2, name: "Пиво", proteins: 10, carbohydrates: 23, fats: 140)]), Recipe(id: 2, name: "Пуддинг", description: "Готовим медленно и не вкусно", ingridients: [Ingridient(id: 3, name: "Шоколад", proteins: 12, carbohydrates: 23, fats: 40), Ingridient(id: 4, name: "Молоко", proteins: 10, carbohydrates: 23, fats: 140)])]))
        }
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
