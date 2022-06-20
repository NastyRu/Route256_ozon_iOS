//
//  AtomActionHandlersPool.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 02.06.2022.
//

final class AtomActionHandlersPool {

    // MARK: Private Properties

    private var handlers: [AtomAction.Behavior: IAtomActionHandler] = [:]

    // MARK: Dependencies

    private let deeplinkHandler: DeeplinkHandler

    // MARK: Initialization

    init(deeplinkHandler: DeeplinkHandler) {
        self.deeplinkHandler = deeplinkHandler

        handlers = [
            .print: PrintAtomActionHandler(),
            .redirect: RedirectAtomActionHandler(deeplinkHandler: deeplinkHandler)
        ]
    }
}

// MARK: - IAtomActionHandlersPool

extension AtomActionHandlersPool: IAtomActionHandlersPool {
    func handler(for action: AtomAction) -> IAtomActionHandler? {
        return handlers[action.behavior]
    }
}
