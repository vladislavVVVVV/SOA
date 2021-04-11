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
    
    func prepareIngridientsViewModel() -> IngridientsViewModel {
        return IngridientsViewModel(appClient: appClient)
    }
    
    func prepareIngridientViewModel(ingridient: Ingridient) -> IngridientViewModel {
        return IngridientViewModel(ingridient: ingridient, appClient: appClient)
    }
}
