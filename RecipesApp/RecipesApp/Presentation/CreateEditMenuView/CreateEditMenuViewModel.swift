//
//  CreateEditMenuViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

enum MenuState: Equatable {
    case create
    case edit(menu: Menu)
}

final class CreateEditMenuViewModel {
    let appClient: AppClientProtocol
    let state: MenuState
    
    init(appClient: AppClientProtocol, state: MenuState) {
        self.state = state
        self.appClient = appClient
    }
    
    func createEditMenu(name: String, ids: [Int], success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        switch state {
        case .create:
            appClient.createMenue(name: name, idRecipes: ids).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        case .edit(let menu):
            appClient.editMenue(with: menu.id ?? 0, name: name, idRecipes: ids).onSuccess { () in
                success()
            }.onFailure { (error) in
                failure(error)
            }
        }
    }
}
