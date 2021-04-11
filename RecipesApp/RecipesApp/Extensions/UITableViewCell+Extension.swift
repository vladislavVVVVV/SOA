//
//  UITableViewCell+Extension.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

// MARK: - Cell identifier from Cell name
extension UITableViewCell {
    static func identifier() -> String {
        return String(describing: self)
    }
}
