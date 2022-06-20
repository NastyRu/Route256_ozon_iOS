//
//  NotificationView.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

import UIKit

final class NotificationView: UIView {
    // MARK: Properties

    var isOnScreen: Bool = false

    // MARK: Private Properties

    private var duration: TimeInterval = .defaultDisplayDuration
    private var topConstraint: NSLayoutConstraint?
    private var action: (() -> Void)?

    // MARK: Subviews

    private var titleLabel: UILabel = .init()
    // messageLabel is fileprivate so UIView.containsNotificationView(withMessage:) can access it.
    fileprivate var messageLabel: UILabel = .init()
    private var imageView: UIImageView = .init()

    // MARK: Initialization

    init?(
        type notificationType: NotificationType,
        title: String? = nil,
        message: String,
        frame: CGRect = .zero,
        action: (() -> Void)? = nil
    ) {
        guard NavigationHierarchy.window?.showsNotificationView(withMessage: message) != true else {
            return nil
        }

        super.init(frame: frame)

        configureLayout()
        setupSubviews()
        configure(notificationType: notificationType,
                  title: title,
                  message: message,
                  action: action)
        addToParentView()
        setupGestureRecognizers()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public

extension NotificationView {
    func show(duration: TimeInterval) {
        self.duration = duration

        isOnScreen = true
        topConstraint?.constant = .superViewOffset

        UIView.animate(
            withDuration: .animationDuration,
            animations: {
                self.superview?.layoutIfNeeded()
            },
            completion: { [duration] _ in
                guard duration > 0 else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.hide()
                }
            }
        )
    }
}

// MARK: - Private (Setup)

private extension NotificationView {
    func setupSubviews() {
        setupNotificationView()
        setupTitleLabel()
        setupMessageLabel()
        setupImageView()
    }

    func setupNotificationView() {
        clipsToBounds = true
        layer.cornerRadius = .cornerRadius
        backgroundColor = .backgroundColor
    }

    func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.font = .bodyLBold
        titleLabel.textColor = .black
    }

    func setupMessageLabel() {
        messageLabel.numberOfLines = 0
        messageLabel.font = .bodyL
        messageLabel.textColor = .black
    }

    func setupImageView() {
        imageView.contentMode = .scaleAspectFit
    }

    func setupGestureRecognizers() {
        let panGestureRecognizer = UIPanGestureRecognizerDirectional(target: self, action: #selector(hide(_:)))
        panGestureRecognizer.direction = .up
        addGestureRecognizer(panGestureRecognizer)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
}

// MARK: - Private (Layout)

private extension NotificationView {
    func addToParentView() {
        guard superview == nil else { return }
        guard let window = NavigationHierarchy.window else { return }

        window.addSubview(self)

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: .superViewOffset),
            trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -.superViewOffset),
        ])

        let topMargin = -frame.size.height - window.safeAreaInsets.top
        topConstraint = topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: topMargin)
        topConstraint?.isActive = true

        window.layoutIfNeeded()
    }

    func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        labelsStackView.axis = .vertical

        let notificationStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView])
        notificationStackView.axis = .horizontal
        notificationStackView.distribution = .fillProportionally
        notificationStackView.alignment = .top
        notificationStackView.spacing = .notificationStackViewSpacing

        notificationStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(notificationStackView)

        NSLayoutConstraint.activate([
            notificationStackView.topAnchor.constraint(equalTo: topAnchor,
                                                       constant: UIEdgeInsets.notificationStackViewEdgeInsets.top),
            notificationStackView.leftAnchor.constraint(equalTo: leftAnchor,
                                                        constant: UIEdgeInsets.notificationStackViewEdgeInsets.left),
            notificationStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                          constant: UIEdgeInsets.notificationStackViewEdgeInsets.bottom),
            notificationStackView.rightAnchor.constraint(equalTo: rightAnchor,
                                                         constant: UIEdgeInsets.notificationStackViewEdgeInsets.right),
        ])

        layoutIfNeeded()
    }
}

// MARK: - Private

private extension NotificationView {
    func configure(notificationType: NotificationType,
                   title: String?,
                   message: String,
                   action: (() -> Void)?) {
        let image: UIImage?
        switch notificationType {
        case .custom(let customImage):
            image = customImage
        case .error:
            image = .errorImage
        case .success:
            image = .successImage
        }

        self.action = action
        imageView.image = image
        titleLabel.text = title
        messageLabel.text = message
    }

    @objc
    func hide(_ sender: UIPanGestureRecognizerDirectional) {
        guard sender.state == .ended else { return }
        hide()
    }

    func hide() {
        topConstraint?.constant = -frame.size.height

        UIView.animate(
            withDuration: .animationDuration,
            animations: {
                self.superview?.layoutIfNeeded()
            },
            completion: { _ in
                self.removeFromSuperview()
                self.isOnScreen = false
                self.showNextNotificationIfNeeded()
            }
        )
    }

    func showNextNotificationIfNeeded() {
        guard let window = NavigationHierarchy.window else { return }

        let notificationViews = window.subviews.filter { $0 is NotificationView }
        if let notificationView = notificationViews.first as? NotificationView {
            notificationView.show(duration: notificationView.duration)
        }
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        guard let action = action else { return }
        hide()
        action()
    }
}

// MARK: - Uniqueness Check

fileprivate extension UIView {
    func showsNotificationView(withMessage message: String) -> Bool {
        for subview in subviews {
            if (subview as? NotificationView)?.messageLabel.text == message {
                return true
            }
        }
        return false
    }
}

// MARK: - Constants

private extension TimeInterval {
    static let defaultDisplayDuration: TimeInterval = 3
    static let animationDuration: TimeInterval = 0.3
}

private extension CGFloat {
    static let superViewOffset: CGFloat = 8
    static let notificationStackViewSpacing: CGFloat = 12
    static let fontSize: CGFloat = 16
    static let cornerRadius: CGFloat = 10
}

private extension UIEdgeInsets {
    static let notificationStackViewEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 12,
                                                                            left: 16, bottom: -16,
                                                                            right: -16)
}

private extension String {
    static let successSFSymbolName: String = "checkmark"
    static let errorSFSymbolName: String = "exclamationmark.triangle"
}

private extension UIImage {
    static let successImage: UIImage? = UIImage(systemName: .successSFSymbolName)?
        .withTintColor(.green, renderingMode: .alwaysOriginal)
    static let errorImage: UIImage? = UIImage(systemName: .errorSFSymbolName)?
        .withTintColor(.yellow, renderingMode: .alwaysOriginal)
}

private extension UIColor {
    static let backgroundColor: UIColor = .gray.withAlphaComponent(0.85)
}
