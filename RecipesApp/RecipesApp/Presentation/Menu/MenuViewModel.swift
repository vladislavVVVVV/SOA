//
//  MenuViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

final class MenuViewModel {
    let selectedMenu: Menu
    let appClient: AppClientProtocol
    
    init(menu: Menu, appClient: AppClientProtocol) {
        self.selectedMenu = menu
        self.appClient = appClient
    }
}
