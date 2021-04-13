//
//  Ingridient.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

struct Ingridient: Equatable, Codable {
    let ingredientId: Int?
    let name: String?
    let proteins: Int?
    let carbohydrates: Int?
    let fats: Int?
}
