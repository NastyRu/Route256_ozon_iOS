//
//  WelcomeWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 10.05.2022.
//

import Foundation

final class WelcomeWidgetAssembly {

    // MARK: Private Properties

    private let decoder = JSONDecoder()

    // MARK: Initialization

    init() {}
}

// MARK: - IWidgetAssembly

extension WelcomeWidgetAssembly: IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel {
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
