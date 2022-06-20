//
//  ButtonAtomView.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

import UIKit

protocol IButtonAtomView: IAtomView {}

final class ButtonAtomView: UIView, IButtonAtomView {

    // MARK: Public Properties

    weak var delegate: AtomViewDelegate?

    // MARK: Private Properties

    private var action: AtomAction?

    // MARK: Subviews

    private var button = UIButton(type: .system)

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) on ButtonAtomView has not been implemented")
    }
}

// MARK: - Public

extension ButtonAtomView {
    func configure(_ model: IAtomModel) {
        guard let model = model as? ButtonAtomModel else { return }
        button.setTitle(model.title, for: .normal)
        action = model.action
    }
}

// MARK: - Private

private extension ButtonAtomView {
    @objc
    func didTapButton() {
        guard let action = action else { return }
        delegate?.atomView(self, didSelectAction: action)
    }
    
    func setupUI() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        addSubview(button)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
