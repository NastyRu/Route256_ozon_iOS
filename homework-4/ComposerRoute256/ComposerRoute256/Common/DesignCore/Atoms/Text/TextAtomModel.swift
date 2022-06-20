//
//  TextAtomModel.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

struct TextAtomModel: IAtomModel, Decodable {
    let text: String
    let textStyle: TextStyle
    let maxLines: Int
}
