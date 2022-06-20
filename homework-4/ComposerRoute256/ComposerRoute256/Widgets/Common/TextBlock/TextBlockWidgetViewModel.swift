//
//  TextBlockWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import UIKit

class TextBlockWidgetViewModel: IWidgetViewModelWithAutoLayoutSizing {
    var model: WidgetModel
    var reuseId: String { "TextBlockWidget" }

    var widgetModel: TextBlockWidgetModel {
        model.parsedModel as! TextBlockWidgetModel
    }

    init(model: WidgetModel) {
        self.model = model
    }
}

