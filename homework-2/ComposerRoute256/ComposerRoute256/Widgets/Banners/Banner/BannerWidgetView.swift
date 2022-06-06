//
//  BannerWidgetView.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

final class BannerWidgetView: UIView, IWidgetView {
    private(set) weak var widgetViewModel: IWidgetViewModel?

    private var viewModel: BannerWidgetViewModel? {
        return widgetViewModel as? BannerWidgetViewModel
    }

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupUI()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(viewModel: IWidgetViewModel) {
        self.widgetViewModel = viewModel
        let viewModel = viewModel as! BannerWidgetViewModel
        updateUI(state: viewModel.widgetModel)
    }

    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -.spacing),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: .spacing),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func updateUI(state: BannerWidgetModel) {
        titleLabel.text = state.title
        subtitleLabel.text = state.subtitle
    }
}

private extension CGFloat {
    static let spacing: CGFloat = 8.0
}
