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
    
    func prepareCreateEditIngridient(state: IngridientState) -> CreateEditIngridientViewModel {
        return CreateEditIngridientViewModel(appClient: appClient, state: state)
    }
    
    func prepareMenuesViewModel() -> MenuesViewModel {
        return MenuesViewModel(appClient: appClient)
    }
    
    func prepareMenuViewModel(menu: Menu) -> MenuViewModel {
        return MenuViewModel(menu: menu, appClient: appClient)
    }
    
    func prepareCreateEditMenuViewModel(state: MenuState) -> CreateEditMenuViewModel {
        return CreateEditMenuViewModel(appClient: appClient, state: state)
    }
    
    func prepareChooseRecipesViewModel(menu: Menu? = nil) -> ChooseRecipeViewModel {
        return ChooseRecipeViewModel(appClient: appClient, menu: menu)
    }
    
    func prepareLoginViewModel(menu: Menu? = nil) -> LoginViewModel {
        return LoginViewModel(appClient: appClient)
    }
}
