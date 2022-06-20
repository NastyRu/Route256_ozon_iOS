import UIKit

final class PageAssemblyContainer {

    // MARK: Public Properties

    var assemblies: [Page: PageAssembly] = [:]

    // MARK: Dependencies

    var composerService: ComposerService!
    var composerConfig: ComposerConfig!
}

// MARK: - Public

extension PageAssemblyContainer {
    func register(assembly: PageAssembly) {
        assemblies[assembly.page] = assembly
    }
    
    func resolveAssembly(for page: Page) -> PageAssembly? {
        assemblies[page]
    }

    func registerAssemblies() {
        register(assembly: HelloPageAssembly())
        register(assembly:
                    ComposerPageAssembly(
                        composerService: composerService,
                        composerConfig: composerConfig
                    )
        )
    }

    func resolveNavigationHandler(page: Page) throws -> INavigationHandler {
        guard let assembly = assemblies[page] else {
            throw ErrorBuilder(errorDescription: "Assembly for page \(page) not found")
        }

        do {
            return try assembly.navigationHandler()
        } catch {
            throw ErrorBuilder(errorDescription: "Cannot build NavigationHandler for page \(page): \(error)")
        }
    }

    func resolveViewController(page: Page, pageInput: PageInput) throws -> UIViewController {
        guard let assembly = assemblies[page] else {
            throw ErrorBuilder(errorDescription: "Assembly for page \(page) not found")
        }

        do {
            return try assembly.build(input: pageInput)
        } catch {
            throw ErrorBuilder(errorDescription: "Cannot build view controller for page \(page): \(error)")
        }
    }

    func resolvePage(url: URL) throws -> Page {
        guard let lowercasedURL = URL(string: url.absoluteString.lowercased()),
              let normalized = lowercasedURL.normalizedURL else {
            throw ErrorBuilder(errorDescription: "Can't resolve page for deeplink: \(url)")
        }

        /// убираем первый "/"
        let pathComponents = normalized.pathComponents.dropFirst()

        let pages = Array(assemblies.keys)

        /// Формируем  массив всех поддерживаемых диплинков
        var availableDeeplinks = pages
            .map { String($0.deeplink.lowercased()) }

        pathComponents.forEach { component in
            availableDeeplinks = availableDeeplinks.filter { $0.contains(component) }
        }

        guard let resolvedDeeplink = availableDeeplinks.first else {
            throw ErrorBuilder(errorDescription: "Can't resolve page for deeplink: \(url)")
        }

        let page = pages.first(where: { page in
            page.deeplink.caseInsensitiveCompare(resolvedDeeplink) == .orderedSame
        })

        guard let resolvedPage = page else {
            print("⛔ Can't resolve page for deeplink \(url)")
            throw ErrorBuilder(errorDescription: "Can't resolve page for deeplink: \(url)")
        }

        return resolvedPage
    }
}

// MARK: - URL Helpers

private extension URL {
    var normalizedURL: URL? {
        var normalizedPath = ""

        if scheme == .routeScheme, let host = host {
            normalizedPath.append("/\(host)")
        }

        normalizedPath.append(isEmptyPath && normalizedPath.isEmpty ? "/home": path)

        var components = URLComponents()
        components.path = normalizedPath

        return components.url
    }

    var isRoute256Link: Bool {
        return scheme == nil || scheme == .routeScheme
    }

    var isEmptyPath: Bool {
        return path.trimmingCharacters(in: .init(charactersIn: "/")).isEmpty
    }
}

// MARK: - Constants

private extension String {
    static let routeScheme: String = "route256"
}
