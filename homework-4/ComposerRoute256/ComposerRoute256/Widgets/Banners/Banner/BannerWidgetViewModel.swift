//
//  BannerWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

class BannerWidgetViewModel: IWidgetViewModel {
    var model: WidgetModel

    var reuseId: String { "BannerWidget" }

    // 1
    private let actionResolver: IAtomActionResolver

    // 2
    func sizeFor(composerSize: CGSize) -> CGSize {
        CGSize(width: composerSize.width, height: 120)
    }

    // 3
    init(model: WidgetModel,
         actionResolver: IAtomActionResolver) {
        self.model = model
        self.actionResolver = actionResolver
    }

    // 4
    func resolveAtomAction(_ action: AtomAction) {
        actionResolver.resolve(atomAction: action)
    }

    func navigation(to url: String) {
        guard let deeplink = URL(string: url) else { return }
        try? CompositionRoot.shared.deeplinkHandler.handle(deeplink: deeplink)
    }

    var widgetModel: BannerWidgetModel {
        model.parsedModel as! BannerWidgetModel
    }
}
