//
//  IAtomActionHandler.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 02.06.2022.
//

protocol IAtomActionHandler: AnyObject {
    // Непосредственно обрабатывает действие
    func handle(atomAction: AtomAction)
}
