//
//  EditTaskViewTests.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ToDoList

private let referenceSize = CGSize(width: 350, height: 50)

class EditTaskViewTests: XCTestCase {

    func testEditTaskView_high() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.high,
            isCompleted: true
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testEditTaskView_low() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.low,
            isCompleted: true
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testEditTaskView_middle() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testEditTaskView_critical() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.critical,
            isCompleted: true
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testEditTaskView_completed() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testEditTaskView_notCompeted() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testTasksListItemView_fillFields() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testTasksListItemView_emptyFields() throws {
        let task = TaskModel(
            title: "",
            description: "",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = EditTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
}
