//
//  RedirectAtomActionHandler.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import Foundation

final class RedirectAtomActionHandler {
    private let deeplinkHandler: DeeplinkHandler
    init(deeplinkHandler: DeeplinkHandler) {
        self.deeplinkHandler = deeplinkHandler
    }
}

// MARK: - IAtomActionHandler

extension RedirectAtomActionHandler: IAtomActionHandler {
    func handle(atomAction: AtomAction) {
        guard let stringURL = atomAction.params?["link"],
              let url = URL(string: stringURL)
        else {
            print("Error with handling")
            return
        }
        try? deeplinkHandler.handle(deeplink: url)
    }
}
