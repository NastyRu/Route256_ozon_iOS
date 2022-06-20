//
//  WidgetIncidentTableViewCell.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

final class WidgetIncidentTableViewCell: UITableViewCell {

    // MARK: Private Properties

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = .autoupdatingCurrent
        return dateFormatter
    }()

    // MARK: Overrides

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Public

extension WidgetIncidentTableViewCell {
    func configure(withIncident incident: WidgetParsingIncident) {
        let text = [
            incident.vertical,
            incident.widgetName,
            incident.widgetVersion,
        ].joined(separator: ".")

        textLabel?.text = text

        detailTextLabel?.text = WidgetIncidentTableViewCell.dateFormatter.string(from: incident.date)

        accessoryType = .disclosureIndicator
    }
}
