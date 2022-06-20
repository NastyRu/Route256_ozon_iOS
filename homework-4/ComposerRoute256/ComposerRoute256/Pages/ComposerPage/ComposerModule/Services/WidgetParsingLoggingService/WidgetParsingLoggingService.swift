//
//  WidgetParsingLoggingService.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

// Синглтон сервис для хранения информации о нераспарсенных виджетах.
final class WidgetParsingLoggingService: IWidgetParsingLoggingService {

    // MARK: Singleton

    static let shared = WidgetParsingLoggingService()

    // MARK: Properties

    var incidents: [WidgetParsingIncident] {
        queue.sync {
            _incidents
        }
    }

    // MARK: Private Properties

    private let queue: DispatchQueue
    private let notificationCenter: NotificationCenter
    private var _incidents: [WidgetParsingIncident] = []

    // MARK: Initialization

    private init() {
        queue = .init(label: "ru.route256.widgetParsingLoggingService", attributes: .concurrent)
        notificationCenter = .default
        notificationCenter.addObserver(self,
                                       selector: #selector(clear),
                                       name: UIApplication.didReceiveMemoryWarningNotification,
                                       object: nil)
    }
}

// MARK: - WidgetParsingLoggingService

extension WidgetParsingLoggingService {
    func logIncident(_ incident: WidgetParsingIncident) {
        queue.async(flags: .barrier) {
            self._incidents.append(incident)
        }
    }
}

// MARK: - Private

private extension WidgetParsingLoggingService {
    @objc
    func clear() {
        queue.async(flags: .barrier) {
            self._incidents.removeAll()
        }
    }
}
