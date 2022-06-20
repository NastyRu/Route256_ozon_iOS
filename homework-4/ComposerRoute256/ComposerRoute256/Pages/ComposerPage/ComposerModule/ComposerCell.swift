//
//  ComposerCell.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

final class ComposerCell: UICollectionViewCell {
    var widgetView: IWidgetView? = nil {
        didSet {
            if let widgetView = widgetView {
                widgetView.translatesAutoresizingMaskIntoConstraints = false
                contentView.insertSubview(widgetView, at: 0)
                let top = widgetView.topAnchor.constraint(equalTo: contentView.topAnchor)
                let leading = widgetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
                let bottom = widgetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                let trailing = widgetView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                bottom.priority = .required - 1
                trailing.priority = .required - 1
                NSLayoutConstraint.activate([top, leading, bottom, trailing])
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        widgetView?.frame = bounds
    }
}
