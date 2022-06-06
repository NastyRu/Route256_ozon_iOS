//
//  NavigationHierarchy.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

final class NavigationHierarchy {

    // MARK: Properties

    public static var window: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first
        guard let delegate = scene?.delegate as? SceneDelegate else { return nil }
        return delegate.window
    }

    public static var topViewController: UIViewController? {
        getTopViewController(base: window?.rootViewController)
    }

    // MARK: Initialization

    @available(*, unavailable, message: "NavigationHierarchy class is static and cannot be instantiated")
    init() {}
}

// MARK: - Private

private extension NavigationHierarchy {
    static func getTopViewController(base: UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }

        if let selectTab = base as? UITabBarController {
            if let selected = selectTab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }

        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }

        return base
    }
}
