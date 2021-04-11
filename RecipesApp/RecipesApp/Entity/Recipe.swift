//
//  Recipe.swift
//  RecipeApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

struct Recipe: Equatable {
    let id: Int?
    let name: String?
    let description: String?
    let ingridients: [Ingridient]?
}
