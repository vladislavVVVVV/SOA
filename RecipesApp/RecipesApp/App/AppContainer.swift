//
//  AppContainer.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import Foundation

final class AppContainer {
    private lazy var appClient: AppClientProtocol = AppClient()
    
    func prepareNewsTabBarController() -> MainTabBarController {
        return MainTabBarController()
    }

//    func prepareViewNewsViewModel(news: News) -> ViewNewsViewModel {
//        return ViewNewsViewModel(news: news, internetReachabilityManager: internetReachabilityManager)
//    }
}
