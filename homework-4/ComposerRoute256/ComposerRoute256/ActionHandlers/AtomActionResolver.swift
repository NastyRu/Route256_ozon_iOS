//
//  AtomActionResolver.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

protocol IAtomActionResolver {
    // Принимает действие и обрабатывает его
    func resolve(atomAction: AtomAction)
}

struct DefaultAtomActionResolver {
    // MARK: Private Properties

    private let pool: IAtomActionHandlersPool

    // MARK: Initialization

    init(pool: IAtomActionHandlersPool) {
        self.pool = pool
    }
}

// MARK: - IAtomActionResolver

extension DefaultAtomActionResolver: IAtomActionResolver {
    func resolve(atomAction: AtomAction) {
        pool.handler(for: atomAction)?.handle(atomAction: atomAction)
    }
}
