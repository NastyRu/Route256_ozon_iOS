//
//  ErrorBuilder.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 01.06.2022.
//

import Foundation

struct ErrorBuilder: Error, LocalizedError {
    var errorDescription: String?

    init(errorDescription: String?) {
        self.errorDescription = errorDescription
    }
}
