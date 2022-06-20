//
//  ButtonAtomModel.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

struct ButtonAtomModel: IAtomModel, Decodable {
    let title: String
    let action: AtomAction?
}
