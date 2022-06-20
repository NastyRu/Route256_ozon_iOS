import UIKit

final class HelloPageAssembly: PageAssembly {
    var page: Page = .init("HelloPage", deeplink: "/hello")
    
    func build(input: PageInput?) throws -> UIViewController {
        guard let input = input as? HelloPageInput else {
            throw ErrorBuilder(errorDescription: "\(self) Invalid input")
        }
        
        let viewController = HelloPageViewController()
        viewController.greetingLabel.text = input.greeting
        viewController.modalPresentationStyle = .fullScreen
        
        return viewController
    }
    
    func navigationHandler() throws -> INavigationHandler {
        HelloPageNavigationHandler()
    }
}
