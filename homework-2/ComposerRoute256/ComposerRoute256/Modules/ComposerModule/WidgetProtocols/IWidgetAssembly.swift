//
//  IWidgetAssembly.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

protocol IWidgetAssembly {
    func buildWidgetModel(meta: WidgetMeta, data: Data) throws -> WidgetModel
    func buildWidgetViewModel(model: WidgetModel) -> IWidgetViewModel
    func buildWidgetView() -> IWidgetView
}
