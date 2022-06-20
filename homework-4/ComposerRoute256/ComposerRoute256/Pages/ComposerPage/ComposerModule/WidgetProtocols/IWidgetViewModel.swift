//
//  IWidgetViewModel.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

protocol IWidgetViewModel: AnyObject {
    var model: WidgetModel { get }
    var reuseId: String { get }

    func sizeFor(composerSize: CGSize) -> CGSize
}

// MARK: - Default Implementation

extension IWidgetViewModel {
    func sizeFor(composerSize: CGSize) -> CGSize {
        assertionFailure("\(self) sizeFor(composerSize:) is not implemented")
        return .zero
    }
}
