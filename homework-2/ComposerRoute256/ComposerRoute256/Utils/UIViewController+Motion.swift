//
//  UIViewController+Motion.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 16.05.2022.
//

import UIKit

extension UIViewController {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == .motionShake {
            if let vc = NavigationHierarchy.topViewController {
                let errorsViewController = WidgetParsingErrorsViewController(widgetParsingLoggingservice: WidgetParsingLoggingService.shared)
                let navController = UINavigationController(rootViewController: errorsViewController)
                vc.present(navController, animated: true)
            }
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}
