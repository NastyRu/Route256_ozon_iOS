//
//  AtomAction.swift
//  ComposerRoute256
//
//  Created by Marinin Aleksey Konstantinovich on 31.05.2022.
//

struct AtomAction: Decodable, Hashable {
    public let behavior: Behavior
    public let params: [String: String]?
    
    public init(behavior: Behavior,
                params: [String: String]? = nil) {
        self.behavior = behavior
        self.params = params
    }
}

extension AtomAction {
    enum Behavior: String, Decodable, RawRepresentable {
        case custom = "BEHAVIOR_TYPE_CUSTOM"
        case print = "BEHAVIOR_TYPE_PRINT"
        case redirect = "BEHAVIOR_TYPE_REDIRECT"
    }
}
