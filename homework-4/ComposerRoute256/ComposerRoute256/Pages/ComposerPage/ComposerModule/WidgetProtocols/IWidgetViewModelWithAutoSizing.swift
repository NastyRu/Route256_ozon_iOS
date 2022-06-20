//
//  IWidgetViewModelWithAutoSizing.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 04.06.2022.
//

import UIKit

protocol IWidgetViewModelWithAutoLayoutSizing: IWidgetViewModel {
    func sizeThatFits(composerConfig: ComposerConfig, containerSize: CGSize) -> CGSize
}

// MARK: - Default Implementation

extension IWidgetViewModelWithAutoLayoutSizing {
    func sizeThatFits(composerConfig: ComposerConfig, containerSize: CGSize) -> CGSize {
        // По сути, мы создаём вью-копию виджета,
        // биндим вьюмоделькой,
        // заставялем систему посчитать за нас размер через автолэйаут.
        // Это даёт достаточно большой оверхед, но такой вариант работает.
        let view = composerConfig.widgetAssembly(for: model.meta)?.buildWidgetView()
        view?.translatesAutoresizingMaskIntoConstraints = false
        view?.widthAnchor.constraint(equalToConstant: containerSize.width).isActive = true
        view?.bind(viewModel: self)
        view?.layoutIfNeeded()
        return view?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? .zero
    }
}
