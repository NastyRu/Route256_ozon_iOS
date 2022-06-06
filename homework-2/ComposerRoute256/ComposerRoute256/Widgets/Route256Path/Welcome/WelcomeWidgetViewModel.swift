//
//  WelcomeWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by a.g.sidenko on 06.06.2022.
//

import UIKit

class WelcomeWidgetViewModel: IWidgetViewModel {
    var model: WidgetModel

    var reuseId: String { "WelcomeWidget" }

    func sizeFor(composerSize: CGSize) -> CGSize {
        CGSize(width: composerSize.width, height: composerSize.width + 50)
    }

    init(model: WidgetModel) {
        self.model = model
    }

    var widgetModel: WelcomeWidgetModel {
        model.parsedModel as! WelcomeWidgetModel
    }
}
