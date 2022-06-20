//
//  ComposerResponse.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

// Модель для декодинга массива layout и nextURL
struct ComposerResponse: Decodable {
    let layout: [LayoutComponent]
    let nextURL: URL?
}
