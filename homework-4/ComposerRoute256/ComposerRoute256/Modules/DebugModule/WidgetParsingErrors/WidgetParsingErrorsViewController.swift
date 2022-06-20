//
//  WidgetParsingErrorsViewController.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

final class WidgetParsingErrorsViewController: UIViewController {

    // MARK: Private Properties

    private let incidents: [WidgetParsingIncident]

    // MARK: Subviews

    private let tableView: UITableView

    // MARK: Initialziation

    init(widgetParsingLoggingservice: IWidgetParsingLoggingService) {
        incidents = widgetParsingLoggingservice.incidents.reversed()

        tableView = .init()

        super.init(nibName: nil, bundle: nil)

        title = "Ошибки парсинга виджетов"
        setupTableView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension WidgetParsingErrorsViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WidgetIncidentTableViewCell.self, forCellReuseIdentifier: .cellIdentifier)
    }
}

// MARK: - UITableViewDelegate

extension WidgetParsingErrorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedIncident = incidents[indexPath.row]
        let detailsViewController = WidgetParsingErrorsDetailsViewController(incident: selectedIncident)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension WidgetParsingErrorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let incident = incidents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellIdentifier, for: indexPath)
        (cell as? WidgetIncidentTableViewCell)?.configure(withIncident: incident)
        return cell
    }
}

// MARK: - Constants

private extension String {
    static let cellIdentifier = "incidentCell"
}
