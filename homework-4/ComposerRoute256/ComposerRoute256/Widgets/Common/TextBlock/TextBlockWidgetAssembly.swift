//
//  TextBlockWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import Foundation

final class TextBlockWidgetAssembly {
    // MARK: Dependencies

    private let atomViewFactory: IAtomViewFactory

    // MARK: Initialization

    init(atomViewFactory: IAtomViewFactory) {
        self.atomViewFactory = atomViewFactory
    }
}

// MARK: - IWidgetAssembly

extension TextBlockWidgetAssembly: IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel {
        let decoder = JSONDecoder()
        let parsedModel = try decoder.decode(TextBlockWidgetModel.self, from: data)

        return WidgetModel(meta: meta, parsedModel: parsedModel)
    }

    func buildWidgetViewModel(model: WidgetModel) -> IWidgetViewModel {
        TextBlockWidgetViewModel(model: model)
    }

    func buildWidgetView() -> IWidgetView {
        TextBlockWidgetView(atomViewFactory: atomViewFactory)
    }
}
