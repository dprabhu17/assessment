//
//  UIImage+Extension.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit

// MARK: Color Assets
extension UIImage {
    static func get(_ asset: ImageAsset) -> UIImage? {
        asset.image
    }
}

// MARK: Enum to load colors from Color asset
enum ImageAsset: String {
    case iconFilterEnabled
    case iconFilterDisabled
    case placeholder
    var image: UIImage? {
        UIImage.init(named: self.rawValue) ?? nil
    }
}
