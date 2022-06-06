//
//  BannerWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

class BannerWidgetViewModel: IWidgetViewModel {
    var model: WidgetModel

    var reuseId: String { "BannerWidget" }

    func sizeFor(composerSize: CGSize) -> CGSize {
        CGSize(width: composerSize.width, height: 80)
    }

    init(model: WidgetModel) {
        self.model = model
    }

    var widgetModel: BannerWidgetModel {
        model.parsedModel as! BannerWidgetModel
    }
}
