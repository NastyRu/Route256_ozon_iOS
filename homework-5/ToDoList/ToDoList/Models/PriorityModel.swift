//
//  PriorityModel.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import Foundation

enum PriorityModel: String, Codable {
    case low = "Низкий"
    case middle = "Средний"
    case high = "Высокий"
    case critical = "Критический"
}
