//
//  UIViewController+EmptyState.swift
//  ComposerRoute256
//
//  Created by Ilin Evgeniy Viktorovich on 18.05.2022.
//

import UIKit

extension UIViewController {
    var emptyStateViewController: EmptyStateViewController? {
        get {
            guard let emptyStateViewController = objc_getAssociatedObject(self, &AssociatedObjectKeys.emptyStateViewController) as? EmptyStateViewController else { return nil }
            return emptyStateViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKeys.emptyStateViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func hideEmptyState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let emptyStateViewController = self.emptyStateViewController else { return }
            emptyStateViewController.willMove(toParent: nil)
            emptyStateViewController.removeFromParent()
            emptyStateViewController.view.removeFromSuperview()
        }
    }

    func showEmptyState(_ error: Error? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let vc = EmptyStateViewController()

            if let error = error {
                let viewModel = EmptyStateViewModel(title: .somethingWentWrong,
                                                    subtitle: error.localizedDescription)
                vc.configure(with: viewModel)
            }

            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)

            self.emptyStateViewController = vc

            vc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])

            self.emptyStateViewController?.delegate = self as? EmptyStateActionDelegate
        }
    }
}

// MARK: - Constants

fileprivate extension UIViewController {
    struct AssociatedObjectKeys {
        static var emptyStateViewController = "emptyStateViewController"
    }
}

private extension String {
    static let somethingWentWrong: String = "Что-то пошло не так"
}
