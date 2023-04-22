//
//  UIImage+Extension.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit

// MARK: Color Assets
extension UIImage {
    // To get image from application's image asset
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

extension UIImageView {
    func setImage(url: String?) {
        self.image = UIImage.get(.placeholder)
        CustomDownloadManager.shared.downloadImage(url: url) { image, _, _, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = nil
                    self.image = image
                }
            }
        }
    }
}
