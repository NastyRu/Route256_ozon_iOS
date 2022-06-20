//
//  WelcomeWidgetModel.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 10.05.2022.
//

import Foundation

struct WelcomeWidgetModel: Decodable {
    let items: [WelcomeWidgetItem]
    let footer: WelcomeWidgetFooter
}

struct WelcomeWidgetItem: Decodable {
    let imageURL: String

    private enum CodingKeys: String, CodingKey {
        case imageURL = "image"
    }
}

struct WelcomeWidgetFooter: Decodable {
    let text: String
}
