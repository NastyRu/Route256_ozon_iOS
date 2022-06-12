//
//  ListItemViewModel.swift
//  Homework-3
//
//  Created by Kazakova Nataliya on 01.06.2022.
//

import Foundation

public final class ListItemViewModel: Identifiable {
    
    public let id: String = UUID().uuidString
    
    let title: String
    let genre: String
    let yearOfPublishing: String
    let tags: [Tag]
    let image: String
    
    init(title: String, genre: String, yearOfPublishing: String, tags: [Tag], image: String) {
        self.title = title
        self.genre = genre
        self.yearOfPublishing = yearOfPublishing
        self.tags = tags
        self.image = image
    }
}
