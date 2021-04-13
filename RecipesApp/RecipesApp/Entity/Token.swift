//
//  Token.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct Token: Codable {
    let token: String?
    let success: Bool?
    let errors: [String]?
}
