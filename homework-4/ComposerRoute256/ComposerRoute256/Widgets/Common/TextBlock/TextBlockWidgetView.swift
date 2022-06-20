//
//  TextBlockWidgetView.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import Foundation
import UIKit

final class TextBlockWidgetView: UIView {

    // MARK: Private Properties

    private(set) weak var widgetViewModel: IWidgetViewModel?

    private var viewModel: TextBlockWidgetViewModel? {
        return widgetViewModel as? TextBlockWidgetViewModel
    }

    // MARK: Subviews

    let textView: ITextAtomView

    // MARK: Initialization

    init(atomViewFactory: IAtomViewFactory) {
        textView = atomViewFactory.buildText()

        super.init(frame: .zero)
        setupUI()
        layoutUI()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IWidgetView

extension TextBlockWidgetView: IWidgetView {
    func bind(viewModel: IWidgetViewModel) {
        widgetViewModel = viewModel
        let viewModel = viewModel as! TextBlockWidgetViewModel
        updateUI(state: viewModel.widgetModel)
    }
}

// MARK: - Private

private extension TextBlockWidgetView {
    func setupUI() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
    }

    func layoutUI() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .horizontalSpacing),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.horizontalSpacing),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: .verticalSpacing),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.verticalSpacing)
        ])
    }

    func updateUI(state: TextBlockWidgetModel) {
        guard let model = state.text else { return }
        textView.configure(model)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let verticalSpacing: CGFloat = 8.0
    static let horizontalSpacing: CGFloat = 16.0
}

