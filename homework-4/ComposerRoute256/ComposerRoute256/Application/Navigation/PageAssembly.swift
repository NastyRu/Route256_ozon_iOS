import UIKit

protocol PageAssembly {
    var page: Page { get }
    func build(input: PageInput?) throws -> UIViewController
    func navigationHandler() throws -> INavigationHandler
}
