//
//  IngridientViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

final class IngridientViewModel {
    let selectedIngridient: Ingridient
    let appClient: AppClientProtocol
    
    init(ingridient: Ingridient, appClient: AppClientProtocol) {
        self.selectedIngridient = ingridient
        self.appClient = appClient
    }
}
