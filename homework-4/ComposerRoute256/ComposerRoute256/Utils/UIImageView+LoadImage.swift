//
//  UIImageView+LoadImage.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//
//  https://gist.github.com/jmfdz/ad71b1b8b30bc3ff23130f8d692acab1
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let mimeType = httpResponse.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
