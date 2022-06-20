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
            let scene = UIApplication.shared.connectedScenes.first
            guard let delegate = scene?.delegate as? SceneDelegate else { return }
            guard let debugMenuLink = URL(string: "route256tech://debug") else { return }
            try? delegate.deeplinkHandler.handle(deeplink: debugMenuLink)
        } else {
            super.motionEnded(motion, with: event)
        }
    }
}
