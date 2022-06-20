//
//  ComposerPageNavigationHandler.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import Foundation

final class ComposerPageNavigationHandler: INavigationHandler {
    func transition(deeplink: URL) throws -> Transition {
        guard let url = deeplink.queryItems?["url"] else {
            throw ErrorBuilder(errorDescription: "\(self) Missing url in deeplink")
        }
        let pageInput = ComposerPageInput(startURL: URL(string: url))
        return .init(type: .push(page: .init("ComposerPage"), pageInput: pageInput, animated: true))
    }

    func transition(page: Page, pageInput: PageInput) throws -> Transition {
        return .init(type: .push(page: page, pageInput: pageInput, animated: true))
    }
}
