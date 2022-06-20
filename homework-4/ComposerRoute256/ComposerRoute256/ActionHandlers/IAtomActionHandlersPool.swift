//
//  IAtomActionHandlersPool.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 02.06.2022.
//

protocol IAtomActionHandlersPool {
    // Отдаёт обработчик для экшена, если существует подходящий обработчик.
    func handler(for action: AtomAction) -> IAtomActionHandler?
}
