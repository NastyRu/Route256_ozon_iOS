//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import Foundation

final class TaskViewModel: ObservableObject {
    var userDefaultsService: UserDefaultsProtocol
    
    @Published var tasks: [TaskModel] = [] {
        didSet {
            saveTasks()
        }
    }
    
    init(userDefaultsService: UserDefaultsProtocol) {
        self.userDefaultsService = userDefaultsService
        guard
            let decodedData = userDefaultsService.data,
            let savedTasks = try? JSONDecoder().decode([TaskModel].self, from: decodedData)
        else { return }
        
        tasks = savedTasks
    }
    
    func deleteTask(indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func addTask(
        title: String,
        description: String,
        priority: String
    ) {
        let newTask = TaskModel(
            title: title,
            description: description,
            priority: PriorityModel(rawValue: priority) ?? PriorityModel.middle,
            isCompleted: false
        )
        tasks.append(newTask)
    }
    
    func updateTask(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }
    
    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            userDefaultsService.data = encodedData
        }
    }
}
