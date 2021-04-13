//
//  RecipeRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct RecipeRequest: Equatable, Codable {
    let recipeId: Int
    let name: String
    let ingridients: [IngridientRequest]
    
    enum CodingKeys: String, CodingKey {
        case recipeId = "recipeId"
        case name = "name"
        case ingridients = "ingridients"
    }
    
    init(recipe: Recipe) {
        self.recipeId = recipe.recipeId ?? 0
        self.name = recipe.name ?? ""
        var igrs: [IngridientRequest] = []
        recipe.ingredients?.forEach { (ing) in
            igrs.append(IngridientRequest(ingridient: ing))
        }
        self.ingridients = igrs
    }
    
    init(recipeId: Int, name: String, ingridients: [IngridientRequest]) {
        self.recipeId = recipeId
        self.name = name
        self.ingridients = ingridients
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.recipeId, forKey: .recipeId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.ingridients, forKey: .ingridients)
    }
}
