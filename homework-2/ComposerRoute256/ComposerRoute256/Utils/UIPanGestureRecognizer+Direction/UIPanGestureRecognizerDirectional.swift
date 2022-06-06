//
//  UIPanGestureRecognizerDirectional.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 17.05.2022.
//

import UIKit.UIGestureRecognizerSubclass

class UIPanGestureRecognizerDirectional: UIPanGestureRecognizer {
    // MARK: Properties

    var direction: UIPanGestureRecognizerDirection = .any

    // MARK: Private Properties

    /// Ожидаем ли мы следующего сдвига для определения валидного направления
    private var pending: Bool = false

    // MARK: Overrides

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        guard direction != .none else { // Сразу фейлим UIPanGestureRecognizer, т.к. у него UIPanGestureRecognizerDirection == .none
            state = .failed
            return
        }
        guard direction != .any else { // Не требуется определять направление UIPanGestureRecognizer, т.к. у него доступны все направления
            return
        }
        pending = true
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        guard pending == true else {
            return
        }
        let directions = touches
            .map({ (from: $0.previousLocation(in: $0.view), to: $0.location(in: $0.view)) })
            .map({ UIPanGestureRecognizerDirection(from: $0.from, to: $0.to) })
        let moved = directions.contains(where: { $0 != .none })
        guard moved else { // Направление определить невозможно, т.к. не было сдвига. Ждем следующего ненулевого сдвига
            return
        }
        pending = false
        let valid = directions.contains(where: { direction.contains($0) })
        if valid == false { // Начало движения UIPanGestureRecognizer в неподходящую сторону. Фейлим
            state = .failed
        }
    }
}

