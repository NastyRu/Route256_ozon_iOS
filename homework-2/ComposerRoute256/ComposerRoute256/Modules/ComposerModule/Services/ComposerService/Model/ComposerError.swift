//
//  ComposerError.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 03.05.2022.
//

import Foundation

enum ComposerError: Error {
    /// Composer page has no widgets
    case emptyPage
    /// Common composer error, stating, that response decoding failed
    case decodeFailed(Error?)
    /// Failed to deserialize JSON object
    case deserialization(Data)
    /// Failed to parse at least 1 valid widget.
    case parsingError([UnparsedWidget])
}

// MARK: - LocalizedError

extension ComposerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyPage:
            return .emptyPage
        case let .decodeFailed(error):
            var description: String = .decodeFailed
            if let error = error {
                description += .newLine + error.localizedDescription
            }
            return description
        case let .deserialization(data):
            return [
                .deserialization,
                "Data:",
                String(data: data, encoding: .utf8) ?? data.debugDescription,
            ].joined(separator: .newLine)
        case let .parsingError(unparsedWidgets):
            let description: String = .parsingError + " из \(unparsedWidgets.count)"
            return [
                description,
                .shakeDevice
            ].joined(separator: .newLine)
        }
    }
}

// MARK: - Constants

private extension String {
    static let emptyPage: String = "Композерная страница не содержит виджетов"
    static let decodeFailed: String = "Не получилось раздекодить ответ"
    static let deserialization: String = "Не получилось десериализовать JSON"
    static let parsingError: String = "Не получилось распарсить ни один виджет"
    static let shakeDevice: String = "Потряси девайс, чтобы увидеть больше информации"
    static let newLine: String = "\n"
}
