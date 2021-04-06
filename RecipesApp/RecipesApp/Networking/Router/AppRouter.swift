//
//  AppRouter.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import Alamofire

enum AppRouter: NetworkRouter {
    case getNews(category: String)
    
    var method: HTTPMethod {
        switch self {
        case .getNews:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getNews(let category):
            return category + Server.PathComponent.json
        }
    }

    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
}
