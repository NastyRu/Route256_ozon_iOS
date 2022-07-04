//
//  TasksListItemViewTests.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ToDoList

private let referenceSize = CGSize(width: 350, height: 50)

class TasksListItemViewTests: XCTestCase {

    func testTasksListItemView_high() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.high,
            isCompleted: true
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_low() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.low,
            isCompleted: true
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_middle() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_critical() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.critical,
            isCompleted: true
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_completed() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_notCompeted() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_description() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
    
    func testTasksListItemView_emptyDescription() throws {
        let task = TaskModel(
            title: "first",
            description: "",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = TasksListItemView(task: task).referenceFrame()

        assertSnapshot(matching: view, as: .image)
    }
}

private extension SwiftUI.View {
    func referenceFrame() -> some View {
        self.frame(width: referenceSize.width, height: referenceSize.height)
    }
}
