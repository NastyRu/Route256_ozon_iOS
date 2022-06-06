//
//  EmptyStateViewController.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 19.05.2022.
//

import UIKit

final class EmptyStateViewController: UIViewController {

    // MARK: Properties

    weak var delegate: EmptyStateActionDelegate?

    // MARK: Subviews

    private let imageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()
    private let subtitleLabel: UILabel = .init()
    private let actionButton: UIButton = .init(type: .system)

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension EmptyStateViewController {
    func configure(with viewModel: EmptyStateViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        imageView.image = viewModel.image ?? .errorImage
    }
}

// MARK: - Private

private extension EmptyStateViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground

        imageView.contentMode = .scaleAspectFit
        imageView.image = .errorImage

        titleLabel.textAlignment = .center
        titleLabel.font = .bodyLBold
        titleLabel.text = .somethingWentWrong

        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .bodyM
        subtitleLabel.text = .messageTechnicalProblem
        subtitleLabel.numberOfLines = 0

        actionButton.backgroundColor = .lightGray
        actionButton.clipsToBounds = true
        actionButton.layer.cornerRadius = 8

        actionButton.setTitleColor(.white, for: .normal)
        actionButton.setTitle(.actionRefresh, for: .normal)
        actionButton.addTarget(self, action: #selector(didPressActionButton(_:)), for: .touchUpInside)
    }

    func configureLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: .imageSize),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -.imageViewBottomSpacing),
        ])

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .subtitleLabelTopSpacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        ])

        actionButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: .actionButtonTopSpacing),
            actionButton.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: .actionButtonWidth),
            actionButton.heightAnchor.constraint(equalToConstant: .actionButtonHeight),
        ])
    }

    @objc
    func didPressActionButton(_ button: UIButton) {
        delegate?.emptyViewDidInvokeAction()
    }
}

// MARK: - Constants

private extension String {
    static let actionRefresh: String = "Обновить"
    static let somethingWentWrong: String = "Что-то пошло не так"
    static let messageTechnicalProblem: String = "Техническая проблема"
    static let errorSFSymbolName: String = "wifi.exclamationmark"
}

private extension CGFloat {
    static let imageSize: CGFloat = 80
    static let imageViewBottomSpacing: CGFloat = 24
    static let subtitleLabelTopSpacing: CGFloat = 6
    static let actionButtonTopSpacing: CGFloat = 20
    static let actionButtonWidth: CGFloat = 120
    static let actionButtonHeight: CGFloat = 32
}

private extension UIImage {
    static let errorImage: UIImage? = UIImage(systemName: .errorSFSymbolName)?
        .withTintColor(.blue, renderingMode: .alwaysOriginal)
}
