import Foundation

protocol INavigationHandler {
    func transition(deeplink: URL) throws -> Transition
    func transition(page: Page, pageInput: PageInput) throws -> Transition
}
