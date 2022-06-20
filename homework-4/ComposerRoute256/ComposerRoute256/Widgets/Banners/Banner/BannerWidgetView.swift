//
//  BannerWidgetView.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

final class BannerWidgetView: UIView {

    // MARK: Private Properties

    private(set) weak var widgetViewModel: IWidgetViewModel?

    private var viewModel: BannerWidgetViewModel? {
        return widgetViewModel as? BannerWidgetViewModel
    }

    private var deeplink: String?

    // MARK: Subviews

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let buttonView: IButtonAtomView

    // MARK: Initialization

    init(atomViewFactory: IAtomViewFactory) {
        buttonView = atomViewFactory.buildButton()

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

extension BannerWidgetView: IWidgetView {
    func bind(viewModel: IWidgetViewModel) {
        widgetViewModel = viewModel
        let viewModel = viewModel as! BannerWidgetViewModel
        updateUI(state: viewModel.widgetModel)
    }
}

// MARK: - Private

private extension BannerWidgetView {
    func setupUI() {
        titleLabel.font = .headMBold
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.isUserInteractionEnabled = true
        buttonView.delegate = self
        addSubview(buttonView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }

    func layoutUI() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .spacing),
            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            buttonView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: .spacing),
            buttonView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func updateUI(state: BannerWidgetModel) {
        deeplink = state.deeplink
        titleLabel.text = state.title
        subtitleLabel.text = state.subtitle

        buttonView.isHidden = state.button == nil
        state.button.flatMap(buttonView.configure(_:))
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        guard let deeplink = deeplink else { return }
        viewModel?.navigation(to: deeplink)
    }
}

// MARK: - AtomViewDelegate

extension BannerWidgetView: AtomViewDelegate {
    func atomView(_ atomView: UIView, didSelectAction action: AtomAction) {
        viewModel?.resolveAtomAction(action)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let spacing: CGFloat = 8.0
}
