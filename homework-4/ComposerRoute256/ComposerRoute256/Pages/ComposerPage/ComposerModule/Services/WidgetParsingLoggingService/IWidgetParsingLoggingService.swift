//
//  IWidgetParsingLoggingService.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

protocol IWidgetParsingLoggingService {
    var incidents: [WidgetParsingIncident] { get }

    func logIncident(_ incident: WidgetParsingIncident)
}
