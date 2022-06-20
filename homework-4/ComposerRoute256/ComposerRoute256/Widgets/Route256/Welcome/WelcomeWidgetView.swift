//
//  WelcomeWidgetView.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 10.05.2022.
//

import UIKit

final class WelcomeWidgetView: UIView {

    // MARK: Private Properties

    private(set) weak var widgetViewModel: IWidgetViewModel?

    private var viewModel: WelcomeWidgetViewModel? {
        return widgetViewModel as? WelcomeWidgetViewModel
    }

    private let numberOfItems: Int = 3

    // MARK: Subviews

    private let stackView: UIStackView
    private let titleLabel: UILabel

    // MARK: Initialization

    init() {
        stackView = .init()
        titleLabel = UILabel()

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

extension WelcomeWidgetView: IWidgetView {
    func bind(viewModel: IWidgetViewModel) {
        widgetViewModel = viewModel

        let viewModel = viewModel as! WelcomeWidgetViewModel
        updateUI(state: viewModel.viewState)
    }
}

// MARK: - Setup UI

private extension WelcomeWidgetView {
    func setupUI() {
        setupTitleLabel()
        setupStackView()
    }

    func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .bodyLBold
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }

    func setupStackView() {
        // All credits goes to @elkabelaya

        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        addSubview(stackView)

        for _ in 0..<numberOfItems {
            let imageStackView = UIStackView()
            imageStackView.axis = .horizontal
            imageStackView.distribution = .fillEqually
            for _ in 0..<numberOfItems {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill

                NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
                ])

                imageStackView.addArrangedSubview(imageView)
            }
            stackView.addArrangedSubview(imageStackView)
        }
    }
}

// MARK: - Layout UI

private extension WelcomeWidgetView {
    func layoutUI() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

// MARK: - Update UI

private extension WelcomeWidgetView {
    func updateUI(state: WelcomeWidgetViewState) {
        titleLabel.text = state.footer.text
        updateImageViews(with: state.items)
    }

    func updateImageViews(with urls: [URL]) {
        // All credits goes to @elkabelaya

        var num: Int = -1

        for i in 1...numberOfItems {
            let index = i-1

            if urls.count <= index * numberOfItems {
                stackView.arrangedSubviews[index].isHidden = true
            } else {
                let stack = stackView.arrangedSubviews[index] as! UIStackView
                stack.isHidden = false

                for j in 1...numberOfItems {
                    let jindex = j-1
                    num += 1
                    if urls.count > num,
                       urls.indices.contains(num),
                       let imageView = stack.arrangedSubviews[jindex] as? UIImageView {
                        let url = urls[num]
                        imageView.loadImage(from: url)

                        stack.arrangedSubviews[jindex].isHidden = false
                    } else {
                        stack.arrangedSubviews[jindex].isHidden = true
                    }
                }
            }
        }
    }
}
