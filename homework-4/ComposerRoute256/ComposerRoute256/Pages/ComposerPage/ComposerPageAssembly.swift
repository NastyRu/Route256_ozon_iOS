//
//  ComposerPageAssembly.swift
//  ComposerRoute256
//
//  Created by Анастасия Сиденко on 20.06.2022.
//

import UIKit

final class ComposerPageAssembly: PageAssembly {
    var page: Page = .init("ComposerPage", deeplink: "/composer")
    
    private let composerService: ComposerService
    private let composerConfig: ComposerConfig
    
    init(
        composerService: ComposerService,
        composerConfig: ComposerConfig
    ) {
        self.composerService = composerService
        self.composerConfig = composerConfig
    }
    
    func build(input: PageInput?) throws -> UIViewController {
        guard let input = input as? ComposerPageInput else {
            throw ErrorBuilder(errorDescription: "\(self) Invalid input")
        }
        
        let viewController = ComposerPageViewController(
            composerService: composerService,
            composerConfig: composerConfig,
            startURL: input.startURL
        )
        viewController.modalPresentationStyle = .fullScreen
        
        return viewController
    }
    
    func navigationHandler() throws -> INavigationHandler {
        ComposerPageNavigationHandler()
    }
}
