//
//  UIColor+App.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit

// MARK: Color Assets
extension UIColor {
    // To get color from application's color asset
    static func get(_ asset: ColorAsset) -> UIColor {
        asset.color
    }
}

// MARK: Enum to load colors from Color asset
enum ColorAsset: String {
    case appBackground
    case appYellow
    var color: UIColor {
        UIColor(named: self.rawValue) ?? UIColor.white
    }
}
