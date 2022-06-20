//
//  NotificationView+LifeTime.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

import struct Foundation.TimeInterval

extension NotificationView {
    func show(lifetime: NotificationLifeTime = .short) {
        let duration: TimeInterval
        switch lifetime {
        case .long:
            duration = .long
        case .short:
            duration = .short
        case .infinite:
            duration = .infinite
        }
        show(duration: duration)
    }
}

// MARK: - Constants

private extension TimeInterval {
    static let short: TimeInterval = 3
    static let long: TimeInterval = 6
    static let infinite: TimeInterval = 50
}
