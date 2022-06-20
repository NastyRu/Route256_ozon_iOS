//
//  NotificationType.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

import UIKit.UIImage

// MARK: - NotificationType

extension NotificationView {
    enum NotificationType {
        case custom(image: UIImage? = nil)
        case error
        case success
    }
}
