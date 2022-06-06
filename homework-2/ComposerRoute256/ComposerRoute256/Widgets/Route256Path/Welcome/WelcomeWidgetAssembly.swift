//
//  WelcomeWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by a.g.sidenko on 06.06.2022.
//

import Foundation

class WelcomeWidgetAssembly: IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel {
        let decoder = JSONDecoder()
        let parsedModel = try decoder.decode(WelcomeWidgetModel.self, from: data)

        return WidgetModel(meta: meta, parsedModel: parsedModel)
    }

    func buildWidgetViewModel(model: WidgetModel) -> IWidgetViewModel {
        WelcomeWidgetViewModel(model: model)
    }

    func buildWidgetView() -> IWidgetView {
        WelcomeWidgetView()
    }
}
