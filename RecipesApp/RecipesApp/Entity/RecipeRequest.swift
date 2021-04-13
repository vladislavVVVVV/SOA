//
//  RecipeRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct RecipeRequest: Equatable {
    let name: String
    let ingridients: [Ingridient]
}
