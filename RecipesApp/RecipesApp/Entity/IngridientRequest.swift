//
//  IngridientRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct IngridientRequest: Equatable, Codable {
    let ingredientId: Int
    let name: String
    let proteins: Int
    let carbohydrates: Int
    let fats: Int
    
    init(ingridient: Ingridient) {
        self.ingredientId = ingridient.ingredientId ?? 0
        self.name = ingridient.name ?? ""
        self.proteins = ingridient.proteins ?? 0
        self.carbohydrates = ingridient.carbohydrates ?? 0
        self.fats = ingridient.fats ?? 0
    }
    
    init(ingredientId: Int, name: String, proteins: Int, carbohydrates: Int, fats: Int) {
        self.ingredientId = ingredientId
        self.name = name
        self.proteins = proteins
        self.carbohydrates = carbohydrates
        self.fats = fats
    }
}
