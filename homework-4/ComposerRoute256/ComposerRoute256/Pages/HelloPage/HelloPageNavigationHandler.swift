import Foundation

final class HelloPageNavigationHandler: INavigationHandler {
    func transition(deeplink: URL) throws -> Transition {
        guard let greetingText = deeplink.queryItems?["greeting"] else {
            throw ErrorBuilder(errorDescription: "\(self) Missing greeting text in deeplink")
        }
        let pageInput = HelloPageInput(greeting: greetingText)
        return .init(type: .push(page: .init("HelloPage"), pageInput: pageInput, animated: true))
    }

    func transition(page: Page, pageInput: PageInput) throws -> Transition {
        return .init(type: .push(page: page, pageInput: pageInput, animated: true))
    }
}
