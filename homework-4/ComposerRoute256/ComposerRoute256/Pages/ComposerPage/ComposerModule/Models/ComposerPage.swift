//
//  ComposerPage.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Модель страницы, которая возвращается из ComposerService
struct ComposerPage {
    let unparsedWidgets: [UnparsedWidget]
    let widgetModels: [WidgetModel]
    let nextURL: URL?
}
