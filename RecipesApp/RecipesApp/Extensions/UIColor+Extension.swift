//
//  UIColor+Extension.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

// MARK: - Base colors
extension UIColor {
    struct Base {
        static let accent = UIColor(240, 110, 61)
        static let background = UIColor.white
        static let viewBackground = UIColor(233, 233, 231)
        static let selectionColor = UIColor(206, 201, 197)
        static let text = UIColor(34, 34, 32)
        static let subtext = UIColor(100, 108, 99)
        static let accentText = UIColor.white
    }

    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double? = 1.0) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
