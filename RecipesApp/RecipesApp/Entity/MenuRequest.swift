//
//  MenuRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct MenuRequest: Equatable, Codable {
    let menueId: Int
    let name: String
    let recipes: [RecipeRequest]
    
    enum CodingKeys: String, CodingKey {
        case menueId = "menueId"
        case name = "name"
        case recipes = "recipes"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.menueId, forKey: .menueId)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.recipes, forKey: .recipes)
    }
}
