//
//  MenuRequest.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct MenuRequest: Equatable {
    let name: String
    let recipes: [Recipe]
}
