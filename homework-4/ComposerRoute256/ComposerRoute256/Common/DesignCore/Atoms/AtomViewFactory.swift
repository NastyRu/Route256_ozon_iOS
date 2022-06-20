//
//  AtomViewFactory.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

protocol IAtomViewFactory: AnyObject {
    func buildButton() -> IButtonAtomView
    func buildText() -> ITextAtomView
}

final class AtomViewFactory: IAtomViewFactory {
    func buildButton() -> IButtonAtomView {
        return ButtonAtomView()
    }
    
    func buildText() -> ITextAtomView {
        return TextAtomView()
    }
}
