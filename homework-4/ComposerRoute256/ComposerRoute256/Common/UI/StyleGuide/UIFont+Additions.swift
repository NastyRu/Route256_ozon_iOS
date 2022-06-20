//
//  UIFont+Additions.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

extension UIFont {
    class var headL: UIFont {
        return UIFont.systemFont(ofSize: 24, weight: .medium)
    }

    class var headM: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .medium)
    }

    class var headMBold: UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    class var bodyL: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    class var bodyLBold: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    class var bodyM: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
