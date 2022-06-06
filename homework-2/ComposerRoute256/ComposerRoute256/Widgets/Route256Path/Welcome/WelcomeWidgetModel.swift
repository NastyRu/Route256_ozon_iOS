//
//  WelcomeWidgetModel.swift
//  ComposerRoute256
//
//  Created by a.g.sidenko on 06.06.2022.
//

import Foundation

struct WelcomeWidgetModel: Decodable {
    let items: [Item]
    let footer: Footer

    struct Footer: Decodable {
        let text: String
    }

    struct Item: Decodable {
        let image: String
    }
}
