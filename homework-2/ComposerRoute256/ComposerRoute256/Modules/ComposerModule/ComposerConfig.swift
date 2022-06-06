//
//  ComposerConfig.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

class ComposerConfig {
    static let shared = ComposerConfig()

    private var registrations: [String: [String: IWidgetAssembly]] = [:]

    private init() {
        registrations = [
            "banners": [
                "banner": BannerWidgetAssembly()
            ],
            "route256Path": [
                "welcome": WelcomeWidgetAssembly()
            ]
        ]
    }

    func widgetAssembly(for meta: WidgetMeta) -> IWidgetAssembly? {
        registrations[meta.vertical]?[meta.component]
    }
}
