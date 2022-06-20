import Foundation

struct Page {

    // MARK: Public Properties

    /// Имя пейджы. Должно быть уникально. Служит для правильного определения пейджи для диплинка.
    let name: String

    /// Диплинк, который ведёт на пейджу.
    /// Можно сделать массивом, тогда на пейджу будет вести несколько диплинков.
    /// Можно докручивать разную логику (например wildcard).
    private(set) var deeplink: String

    // MARK: Initialization

    /// Инициализатор пейджи.
    /// Поскольку пейджа уникально идентифицируется именем,
    /// если мы хотим вручную перейти на пейджу, нам достаточно указать её имя.
    init(_ name: String, deeplink: String = "") {
        self.name = name
        self.deeplink = deeplink
    }
}

// MARK: - Equatable

extension Page: Equatable {
    static func == (lhs: Page, rhs: Page) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - Hashable

extension Page: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
