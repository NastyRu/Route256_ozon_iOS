//
//  SceneDelegate.swift
//  ComposerRoute256
//
//  Created by Mityuklyaev Vladislav on 14.04.2022.
//

import UIKit

class SceneDelegate: UIResponder {
    var window: UIWindow?
    let compositionRoot: CompositionRoot = .shared
    let deeplinkHandler: DeeplinkHandler = CompositionRoot.shared.deeplinkHandler
}

// MARK: - UIWindowSceneDelegate

extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let composerViewController = ComposerPageViewController(composerService: compositionRoot.composerService,
                                                                composerConfig: compositionRoot.composerConfig,
                                                                startURL: nil)
        let navController = UINavigationController(rootViewController: composerViewController)

        window.rootViewController = navController

        self.window = window
        window.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        try? deeplinkHandler.handle(deeplink: url)
    }
}
