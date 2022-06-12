//
//  Tag.swift
//  Homework-3
//
//  Created by Kazakova Nataliya on 01.06.2022.
//

struct Tag {
    
    let title: String
    let number: Int
    
    init(title: String, number: Int) {
        self.title = title
        self.number = number
    }
}

extension Tag: Equatable {
    static func == (lhs: Tag, rhs: Tag) -> Bool {
        return lhs.title == rhs.title &&
        lhs.number == rhs.number
    }
}
