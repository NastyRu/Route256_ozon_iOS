//
//  TaskModel.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let priority: PriorityModel
    let isCompleted: Bool
    
    init(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        priority: PriorityModel,
        isCompleted: Bool
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.priority = priority
        self.isCompleted = isCompleted
    }
}
