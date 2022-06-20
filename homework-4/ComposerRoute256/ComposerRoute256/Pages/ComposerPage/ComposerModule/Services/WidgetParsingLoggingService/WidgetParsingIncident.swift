//
//  WidgetParsingIncident.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import struct Foundation.Date

// Модель с информацией о неудачной попытке распарсить виджет.
// В отличие от `UnparsedWidget` содержит время и доп.информацию.
struct WidgetParsingIncident {
    let vertical: String
    let widgetName: String
    let widgetVersion: String
    let userInfo: [String: Any]
    let date = Date()
}
