//
//  WelcomeWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 10.05.2022.
//

import UIKit

final class WelcomeWidgetViewModel: IWidgetViewModel {

    // MARK: IWidgetViewModel Properties

    var model: WidgetModel

    var reuseId: String { "WelcomeWidget" }

    var widgetModel: WelcomeWidgetModel {
        model.parsedModel as! WelcomeWidgetModel
    }

    // MARK: - Internal Properties

    var viewState: WelcomeWidgetViewState {
        let items = widgetModel.items.compactMap { URL(string: $0.imageURL) }
        return WelcomeWidgetViewState(items: items,
                                      footer: widgetModel.footer)
    }

    // MARK: Initialization

    init(model: WidgetModel) {
        self.model = model
    }

    // MARK: IWidgetViewModel Methods

    func sizeFor(composerSize: CGSize) -> CGSize {
        return CGSize(width: composerSize.width, height: composerSize.width + 50)
    }
}
