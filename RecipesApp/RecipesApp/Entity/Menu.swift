//
//  Menu.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

struct Menu: Equatable, Codable {
    let menueId: Int?
    let name: String?
    let recipes: [Recipe]?
}
