//
//  UIPanGestureRecognizerDirection.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

import CoreGraphics
import Foundation

/// The direction of the pan
struct UIPanGestureRecognizerDirection: OptionSet {
    let rawValue: Int

    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    init(from: CGPoint, to: CGPoint) {
        let dx = to.x - from.x
        let dy = to.y - from.y
        guard dx != 0 || dy != 0 else {
            self = .none
            return
        }
        if abs(dx) > abs(dy) {
            if dx > 0 {
                self = .right
            } else {
                self = .left
            }
        } else {
            if dy > 0 {
                self = .down
            } else {
                self = .up
            }
        }
    }
}

// MARK: - Static

extension UIPanGestureRecognizerDirection {
    static let none = UIPanGestureRecognizerDirection(rawValue: 1 << 0)

    static let up = UIPanGestureRecognizerDirection(rawValue: 1 << 1)
    static let down = UIPanGestureRecognizerDirection(rawValue: 1 << 2)
    static let left = UIPanGestureRecognizerDirection(rawValue: 1 << 3)
    static let right = UIPanGestureRecognizerDirection(rawValue: 1 << 4)

    static let any: UIPanGestureRecognizerDirection = [.up, .down, .left, .right]
    static let horizontal: UIPanGestureRecognizerDirection = [.left, .right]
    static let vertical: UIPanGestureRecognizerDirection = [.up, .down]
}
