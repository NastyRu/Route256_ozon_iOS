//
//  AtomView.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

import UIKit

protocol IAtomView: UIView {
    var delegate: AtomViewDelegate? { get set }
    func configure(_ model: IAtomModel)
}

protocol AtomViewDelegate: AnyObject {
    func atomView(_ atomView: UIView, didSelectAction action: AtomAction)
}
