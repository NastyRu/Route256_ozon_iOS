//
//  WidgetModel.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Модель для работы с виджетами на уровне composer и assembly
// содержащая в себе vertical, component и декодированную модель виджета
struct WidgetModel {
    let meta: WidgetMeta
    let parsedModel: Any
}
