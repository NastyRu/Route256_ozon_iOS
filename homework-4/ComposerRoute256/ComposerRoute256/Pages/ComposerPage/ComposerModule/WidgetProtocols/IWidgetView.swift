//
//  IWidgetView.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import Foundation
import UIKit

protocol IWidgetView: UIView {
    func bind(viewModel: IWidgetViewModel)
}

