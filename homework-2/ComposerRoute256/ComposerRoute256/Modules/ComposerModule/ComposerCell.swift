//
//  ComposerCell.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

final class ComposerCell: UICollectionViewCell { // тут получилось просто, быстро и легко
    var widgetView: IWidgetView? = nil {
        didSet {
            if let widgetView = widgetView {
                contentView.addSubview(widgetView)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        widgetView?.frame = bounds
    }
}
