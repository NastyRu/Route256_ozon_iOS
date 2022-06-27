//
//  TasksListViewTests.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ToDoList

class ToDoListTests: XCTestCase {
    var userDefaultsService: UserDefaultsProtocol?

    override func setUpWithError() throws {
        userDefaultsService = UserDefaultsMock()
    }

    override func tearDownWithError() throws {
        userDefaultsService = nil
    }

    func testTasksListView_empty() throws {
        guard let userDefaultsService = userDefaultsService else {
            return
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        let view = TasksListView().environmentObject(viewModel)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testTasksListView_oneItem() throws {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode(taskGenerator(count: 1)) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        let view = TasksListView().environmentObject(viewModel)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testTasksListView_manyItems() throws {
        guard var userDefaultsService = userDefaultsService else {
            return
        }
        
        if let encodedData = try? JSONEncoder().encode(taskGenerator(count: 10)) {
            userDefaultsService.data = encodedData
        }

        let viewModel = TaskViewModel(userDefaultsService: userDefaultsService)
        let view = TasksListView().environmentObject(viewModel)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
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
