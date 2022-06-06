//
//  BannerWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

class BannerWidgetAssembly: IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel {
        let decoder = JSONDecoder()
        let parsedModel = try decoder.decode(BannerWidgetModel.self, from: data)

        return WidgetModel(meta: meta, parsedModel: parsedModel)
    }

    func buildWidgetViewModel(model: WidgetModel) -> IWidgetViewModel {
        BannerWidgetViewModel(model: model)
    }

    func buildWidgetView() -> IWidgetView {
        BannerWidgetView()
    }
}
