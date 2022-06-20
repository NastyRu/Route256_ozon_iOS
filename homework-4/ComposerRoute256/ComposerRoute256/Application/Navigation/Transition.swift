import Foundation

struct Transition {
    let type: TransitionType
}

@frozen
enum TransitionType {
    /// Пуш контроллера в навигационный стэк.
    case push(page: Page, pageInput: PageInput, animated: Bool)

    /// Одиночный `pop`.
    case pop(animated: Bool, completion: (() -> Void)? = nil)
    
    /// Present контроллера поверх текущего верхнего.
    case present(page: Page, pageInput: PageInput, animated: Bool, completion: (() -> Void)? = nil)
    
    /// Dismiss текущего верхнего контроллера.
    case dismiss(animated: Bool, completion: (() -> Void)? = nil)
}
