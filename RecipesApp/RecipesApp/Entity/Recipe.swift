//
//  Recipe.swift
//  RecipeApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

struct Recipe: Equatable, Codable {
    let recipeId: Int?
    let name: String?
    let ingredients: [Ingridient]?
}
