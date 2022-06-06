//
//  WelcomeWidgetView.swift
//  ComposerRoute256
//
//  Created by a.g.sidenko on 06.06.2022.
//

import Foundation
import UIKit

final class WelcomeWidgetView: UIView, IWidgetView {
    private(set) weak var widgetViewModel: IWidgetViewModel?

    private var viewModel: WelcomeWidgetViewModel? {
        return widgetViewModel as? WelcomeWidgetViewModel
    }

    let imageView = UIImageView()
    let titleLabel = UILabel()

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
        let viewModel = viewModel as! WelcomeWidgetViewModel
        updateUI(state: viewModel.widgetModel)
    }

    private func setupUI() {
        titleLabel.font = .bodyLBold
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateUI(state: WelcomeWidgetModel) {
        titleLabel.text = state.footer.text
        for item in state.items {
            if let url = URL(string: item.image) {
                let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
                }
                dataTask.resume()
            }
        }
    }
}
