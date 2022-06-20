//
//  ComposerConfig.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation

final class ComposerConfig {

    // MARK: Private Properties

    private var registrations: [String: [String: IWidgetAssembly]] = [:]

    // MARK: Dependencies

    private let pool: IAtomActionHandlersPool
    private let atomViewFactory: IAtomViewFactory

    // MARK: Initilaization

    init(pool: IAtomActionHandlersPool,
         atomViewFactory: IAtomViewFactory) {
        self.pool = pool
        self.atomViewFactory = atomViewFactory

        registrations = [
            "banners": [
                "banner": BannerWidgetAssembly(pool: pool, atomViewFactory: atomViewFactory)
            ],
            "route256Path": [
                "welcome": WelcomeWidgetAssembly()
            ],
            "common": [
                "textBlock": TextBlockWidgetAssembly(atomViewFactory: atomViewFactory)
            ],
        ]
    }

    // MARK: Public Methods

    func widgetAssembly(for meta: WidgetMeta) -> IWidgetAssembly? {
        registrations[meta.vertical]?[meta.component]
    }
}
