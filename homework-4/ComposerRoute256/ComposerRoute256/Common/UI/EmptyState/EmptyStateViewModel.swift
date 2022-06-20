//
//  EmptyStateViewModel.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 20.05.2022.
//

import UIKit

struct EmptyStateViewModel {
    // MARK: Properties

    let title: String
    let subtitle: String
    let image: UIImage?

    // MARK: Initialization

    init(title: String,
         subtitle: String,
         image: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
