//
//  UnparsedWidget.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

// Модель с информацией о нераспарсенном виджете
struct UnparsedWidget {
    let vertical: String
    let component: String
    let version: Int
    let stateID: String
    let reason: Reason

    // Причина, по которой не удалось распарсить виджет
    enum Reason {
        // Не удалось найти стейт виджета
        case notFound
        // Не удалось найти ассембли для виджета
        case assemblyNotFound
        // Не удалось распарсить стейт виджета
        case parsing(Error)
        // Кастоная / любая другая ошибка
        case custom(Error)
    }
}
