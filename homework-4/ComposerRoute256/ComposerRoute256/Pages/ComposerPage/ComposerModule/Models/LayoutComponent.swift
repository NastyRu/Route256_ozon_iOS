//
//  LayoutComponent.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Модель для декодинга элемента layout-списка
struct LayoutComponent: Decodable {
    let meta: WidgetMeta
    let stateID: String
}
