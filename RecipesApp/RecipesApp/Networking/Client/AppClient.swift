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
}

final class AppClient: NetworkClient, AppClientProtocol {
    func getIngridients() -> Future<[Ingridient], NetworkRequestError> {
        //return performRequest(route: AppRouter.getNews(category: category))
        return Future { complition in
            complition(.success([Ingridient(id: 1, name: "Мясо", proteins: 20, carbohydrates: 2, fats: 50), Ingridient(id: 2, name: "Банан", proteins: 100, carbohydrates: 2, fats: 20), Ingridient(id: 3, name: "Гуава", proteins: 2, carbohydrates: 3, fats: 50)]))
        }
    }
}
