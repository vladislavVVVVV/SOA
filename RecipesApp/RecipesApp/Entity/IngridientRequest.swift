//
//  IngridientRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct IngridientRequest: Equatable {
    let name: String
    let proteins: Int
    let carbohydrates: Int
    let fats: Int
}
