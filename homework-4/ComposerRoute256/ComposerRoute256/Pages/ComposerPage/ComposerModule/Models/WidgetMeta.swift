//
//  WidgetMeta.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Модель для декодинга параметров в layout-элементе
struct WidgetMeta: Decodable {
    let vertical: String
    let component: String
    let version: Int
}
