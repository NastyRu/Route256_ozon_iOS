//
//  TextAtomView.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import UIKit

protocol ITextAtomView: IAtomView {}

final class TextAtomView: UIView, ITextAtomView {
    
    // MARK: Public Properties

    weak var delegate: AtomViewDelegate?

    // MARK: Subviews

    private var label = UILabel()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) on TextAtomView has not been implemented")
    }
}

// MARK: - Public

extension TextAtomView {
    func configure(_ model: IAtomModel) {
        guard let model = model as? TextAtomModel else { return }
        
        label.text = model.text
        label.numberOfLines = model.maxLines
        label.font = model.textStyle.font
        label.sizeToFit()
    }
}

// MARK: - Private

private extension TextAtomView {
    func setupUI() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
