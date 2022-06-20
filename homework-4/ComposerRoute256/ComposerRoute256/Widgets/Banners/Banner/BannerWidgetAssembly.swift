//
//  BannerWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

final class BannerWidgetAssembly {
    // MARK: Dependencies

    private let pool: IAtomActionHandlersPool
    private let atomViewFactory: IAtomViewFactory

    // MARK: Initialization

    init(pool: IAtomActionHandlersPool,
         atomViewFactory: IAtomViewFactory) {
        self.pool = pool
        self.atomViewFactory = atomViewFactory
    }
}

// MARK: - IWidgetAssembly

extension BannerWidgetAssembly: IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel {
        let decoder = JSONDecoder()
        let parsedModel = try decoder.decode(BannerWidgetModel.self, from: data)

        return WidgetModel(meta: meta, parsedModel: parsedModel)
    }

    func buildWidgetViewModel(model: WidgetModel) -> IWidgetViewModel {
        BannerWidgetViewModel(model: model,
                              actionResolver: DefaultAtomActionResolver(pool: pool))
    }

    func buildWidgetView() -> IWidgetView {
        BannerWidgetView(atomViewFactory: atomViewFactory)
    }
}
