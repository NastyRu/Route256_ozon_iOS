import UIKit

final class TransitionHandler {
    // MARK: Dependencies

    private let pageAssembliesContainer: PageAssemblyContainer

    // MARK: Initialization

    init(pageAssembliesContainer: PageAssemblyContainer) {
        self.pageAssembliesContainer = pageAssembliesContainer
    }
}

// MARK: - Private Computed Properties

private extension TransitionHandler {
    var topViewController: UIViewController? {
        return NavigationHierarchy.topViewController
    }

    var topNavigationController: UINavigationController? {
        topViewController?.navigationController
    }
}

// MARK: - Public

extension TransitionHandler {
    func navigate(to page: Page, pageInput: PageInput) throws {
        do {
            let handler = try pageAssembliesContainer.resolveNavigationHandler(page: page)
            let transition = try handler.transition(page: page, pageInput: pageInput)
            perform(transition: transition)
        } catch {
            throw ErrorBuilder(errorDescription: "Handler for page \(page) not found")
        }
    }

    func navigate(to url: URL) throws {
        let page = try pageAssembliesContainer.resolvePage(url: url)
        let handler = try pageAssembliesContainer.resolveNavigationHandler(page: page)
        let transition = try handler.transition(deeplink: url)
        perform(transition: transition)
    }

    func perform(transition: Transition) {
        switch transition.type {
        case let .push(page, pageInput, animated):
            push(page: page, pageInput: pageInput, animated: animated)
        case let .pop(animated, completion):
            pop(animated: animated, completion: completion)
        case let .present(page, pageInput, animated, completion):
            present(page: page, pageInput: pageInput, animated: animated, completion: completion)
        case let .dismiss(animated, completion):
            dismiss(animated: animated, completion: completion)
        }
    }
}

// MARK: - Private (Transitions)

private extension TransitionHandler {
    func push(page: Page, pageInput: PageInput, animated: Bool) {
        dismissToNavigationController { [weak self] in
            guard let self = self else { return }
            do {
                let vc = try self.pageAssembliesContainer.resolveViewController(page: page, pageInput: pageInput)
                self.topNavigationController?.pushViewController(vc, animated: animated)
            } catch {
                print(error)
            }
        }
    }

    func pop(animated: Bool, completion: (() -> Void)?) {
        topNavigationController?.popViewController(animated: animated, completion: completion)
    }

    func present(page: Page, pageInput: PageInput, animated: Bool, completion: (() -> Void)?) {
        do {
            let vc = try pageAssembliesContainer.resolveViewController(page: page, pageInput: pageInput)
            let topVC = topNavigationController?.presentedViewController ?? topNavigationController ?? topViewController
            topVC?.present(vc, animated: animated, completion: completion)
        } catch {
            print(error)
        }
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let topViewController = topViewController,
              topViewController.presentedViewController != nil || topViewController.presentingViewController != nil else {
            completion?()
            return
        }

        topViewController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - Private (Helpers)

private extension TransitionHandler {
    func dismissToNavigationController(from viewController: UIViewController? = NavigationHierarchy.topViewController,
                                       target targetNavigationController: UINavigationController? = nil,
                                       completion: @escaping () -> Void) {
        guard let viewController = viewController else {
            completion()
            return
        }

        let navigationController = viewController.navigationController

        let isTargetNavigationController = targetNavigationController == nil || navigationController == targetNavigationController

        guard navigationController == nil || !isTargetNavigationController else {
            completion()
            return
        }

        if let presentingViewController = viewController.presentingViewController {
            viewController.dismiss(animated: true) { [weak self] in
                self?.dismissToNavigationController(from: presentingViewController,
                                                    target: targetNavigationController,
                                                    completion: completion)
            }
        } else {
            completion()
        }
    }
}

// MARK: - UINavigationController Helpers

private extension UINavigationController {
    func popViewController(animated: Bool, completion: (() -> Void)?) {
        popViewController(animated: animated)

        if let coordinator = transitionCoordinator, coordinator.isAnimated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }  else {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
