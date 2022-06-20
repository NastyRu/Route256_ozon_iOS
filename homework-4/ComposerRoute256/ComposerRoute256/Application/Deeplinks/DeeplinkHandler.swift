import UIKit

final class DeeplinkHandler {

    // MARK: Private Properties

    private let transitionHandler: TransitionHandler

    // MARK: Initialization

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: Public

extension DeeplinkHandler {
    func handle(deeplink: URL) throws {
        // Если схема диплинка кастомная (для внутренних нужд),
        // пробуем обработать такой диплинк вне основного флоу.
        guard deeplink.scheme != .techScheme else {
            handleTechDeeplink(deeplink)
            return
        }

        // Если схема диплинка не входит в список обрабатываемых DeeplinkHandler'ом, ничего не делаем.
        guard deeplink.scheme == .routeScheme else { return }

        try transitionHandler.navigate(to: deeplink)
    }
}

// MARK: - Private

private extension DeeplinkHandler {
    func handleTechDeeplink(_ url: URL) {
        switch url.host {
        case "debug":
            openDebugMenu()
        default:
            break
        }
    }

    func openDebugMenu() {
        let errorsViewController = WidgetParsingErrorsViewController(widgetParsingLoggingservice: WidgetParsingLoggingService.shared)
        let navController = UINavigationController(rootViewController: errorsViewController)
        NavigationHierarchy.topViewController?.present(navController, animated: true)
    }
}

// MARK: - Constants

private extension String {
    static let techScheme: String = "route256tech"
    static let routeScheme: String = "route256"
}
