//
//  Extensions.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation
import UIKit

extension String: Error { }

var imageCache = Dictionary<String, UIImage>()

public extension UIImageView {

    func loadImage(from urlString: String?, placeHolder: UIImage?) {

        guard let urlString = urlString,
              let url = URL(string: urlString) else {
                self.image = placeHolder
                return
        }

        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async { self.image = placeHolder }
                return
            }
            DispatchQueue.main.async {
                if let data = data {
                    if let downloadedImage = UIImage(data: data) {
                        imageCache[urlString] = downloadedImage
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
    }
}

class ColorHelper {
    static func uiColorFromHEX(rgb: UInt32) -> UIColor {
        let red = CGFloat((rgb & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgb & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgb & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}
