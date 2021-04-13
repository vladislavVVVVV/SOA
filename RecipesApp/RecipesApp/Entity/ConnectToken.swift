//
//  ConnectToken.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation

struct ConnectToken: Codable {
    let accessToken: String
    let ifv: String?
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token", ifv = "ifv"
    }
}
