//
//  WidgetParsingErrorsDetailsViewController.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

final class WidgetParsingErrorsDetailsViewController: UIViewController {

    // MARK: Subviews

    private let textView: UITextView

    // MARK: Dependencies

    private let incident: WidgetParsingIncident

    // MARK: Initialization

    init(incident: WidgetParsingIncident) {
        self.incident = incident

        textView = .init()

        super.init(nibName: nil, bundle: nil)

        setupSelf()
        setupNavigationItem()
        setupTextView()
        textView.attributedText = buildIncidentReport()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension WidgetParsingErrorsDetailsViewController {
    func setupSelf() {
        view.backgroundColor = .systemBackground
    }

    func setupNavigationItem() {
        let title = [
            incident.vertical,
            incident.widgetName,
            incident.widgetVersion,
        ].joined(separator: ".")

        navigationItem.title = title
    }

    func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        textView.backgroundColor = .systemBackground
    }
}

// MARK: - Builder

private extension WidgetParsingErrorsDetailsViewController {
    func buildIncidentReport() -> NSAttributedString {
        func attributedTitle(_ title: String) -> NSAttributedString {
            return NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.headM,
                    .foregroundColor: UIColor.black,
                ]
            )
        }
        func attributedContent(_ content: String) -> NSAttributedString {
            return NSAttributedString(
                string: content,
                attributes: [
                    .font: UIFont.bodyM,
                    .foregroundColor: UIColor.black,
                ]
            )
        }

        let attributedReport = NSMutableAttributedString()
        let userInfo = incident.userInfo
        if let errorDescription = userInfo[ErrorLogKeys.errorDescription] as? String {
            attributedReport.append(attributedTitle("Error Description:\n"))
            attributedReport.append(attributedContent("\(errorDescription)\n\n"))
        }
        if let decodingError = userInfo[ErrorLogKeys.decodingError] as? String {
            attributedReport.append(attributedTitle("Decoding Error:\n"))
            attributedReport.append(attributedContent("\(decodingError)\n\n"))
        }
        if let error = userInfo[ErrorLogKeys.underlyingError] as? String {
            attributedReport.append(attributedTitle("Raw Error:\n"))
            attributedReport.append(attributedContent("\(error)\n\n"))
        }
        if let state = userInfo[ErrorLogKeys.state] as? [String: Any] {
            attributedReport.append(attributedTitle("State Data:\n"))
            attributedReport.append(attributedContent("\(state)\n\n"))
        }
        return attributedReport
    }
}
