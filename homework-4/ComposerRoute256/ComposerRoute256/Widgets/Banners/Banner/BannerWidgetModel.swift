//
//  BannerWidgetModel.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

struct BannerWidgetModel: Decodable {
    let title: String
    let subtitle: String
    let deeplink: String?
    let button: ButtonAtomModel?
}
