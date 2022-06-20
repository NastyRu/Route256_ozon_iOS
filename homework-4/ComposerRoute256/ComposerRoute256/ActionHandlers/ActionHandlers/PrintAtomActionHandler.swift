//
//  PrintAtomActionHandler.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 26.05.2022.
//

final class PrintAtomActionHandler {}

// MARK: - IAtomActionHandler

extension PrintAtomActionHandler: IAtomActionHandler {
    func handle(atomAction: AtomAction) {
        let message = atomAction.params?["message"] ?? "empty message"
        print("PrintAtomActionHandler print: \(message)")
    }
}
