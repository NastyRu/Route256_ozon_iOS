//
//  TextStyle.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 05.06.2022.
//

import UIKit

@frozen
enum TextStyle: String {
    case headL
    case headM
    case headMBold
    case bodyL
    case bodyLBold
    case bodyM
}

// MARK: - Decodable

extension TextStyle: Decodable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let string = try value.decode(String.self)
        // Конвертируем HEAD_L в headL, BODY_L_BOLD -> bodyLBold
        let components = string.components(separatedBy: "_")
        let rawValue = components
            .enumerated()
            .reduce(into: "") { result, pair in
                var componentString = pair.element.lowercased()
                if pair.offset != .zero {
                    componentString = componentString.capitalized
                }
                result += componentString
            }
        if let textStyle = TextStyle(rawValue: rawValue) {
            self = textStyle
        } else {
            throw ErrorBuilder(errorDescription: "Cannot initialize TextStyle from: \(string)")
        }
    }
}

// MARK: - TextStyle+UIFont

extension TextStyle {
    var font: UIFont {
        switch self {
        case .headL: return .headL
        case .headM: return .headM
        case .headMBold: return .headMBold
        case .bodyL: return .bodyL
        case .bodyLBold: return .bodyLBold
        case .bodyM: return .bodyM
        }
    }
}
