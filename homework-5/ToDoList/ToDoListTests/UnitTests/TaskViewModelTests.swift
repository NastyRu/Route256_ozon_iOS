//
//  TaskViewModelTests.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import XCTest
import SnapshotTesting
@testable import ToDoList

class TaskViewModelTests: XCTestCase {
    var userDefaultsService: UserDefaultsProtocol?

    override func setUpWithError() throws {
        userDefaultsService = UserDefaultsMock()
    }

    override func tearDownWithError() throws {
        userDefaultsService = nil
    }
    
    func testDeleteTask_emptyArray() throws {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode(taskGenerator(count: 1)) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        
        viewModel.deleteTask(indexSet: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.tasks.count, 0)
    }
    
    func testDeleteTask_array() {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode(taskGenerator(count: 4)) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        
        viewModel.deleteTask(indexSet: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.tasks.count, 3)
    }
    
    func testAddTask_toArray() {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode(taskGenerator(count: 4)) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        
        viewModel.addTask(title: "Title", description: "Description", priority: "Средний")
        
        XCTAssertEqual(viewModel.tasks.count, 5)
    }
    
    func testDeleteTask_toEmptyArray() {
        guard let userDefaultsService = userDefaultsService else {
            return
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        viewModel.addTask(title: "Title", description: "Description", priority: "Средний")
        
        XCTAssertEqual(viewModel.tasks.count, 1)
    }
    
    func testUpdateTask() {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        guard var task = taskGenerator(count: 1).first else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode([task]) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        
        task.title = "The best task"
        task.description = "The best description"
        
        viewModel.updateTask(task: task)
        
        XCTAssertEqual(viewModel.tasks.first?.title, "The best task")
        XCTAssertEqual(viewModel.tasks.first?.description, "The best description")
    }
    
    private func taskGenerator(count: Int) -> [TaskModel] {
        var tasks: [TaskModel] = []
        for i in 0..<count {
            tasks.append(TaskModel(
                title: "Task\(i)",
                description: "Description\(i)",
                priority: PriorityModel.middle,
                isCompleted: true
            ))
        }
        
        return tasks
    }
}
