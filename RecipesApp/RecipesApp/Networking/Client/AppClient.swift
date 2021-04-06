//
//  AppClient.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import BrightFutures
import Alamofire

protocol AppClientProtocol {
    //func getNews(category: String) -> Future<NewsSection, NetworkRequestError>
}

final class AppClient: NetworkClient, AppClientProtocol {
//    func getNews(category: String) -> Future<NewsSection, NetworkRequestError> {
//        return performRequest(route: AppRouter.getNews(category: category))
//    }
}
