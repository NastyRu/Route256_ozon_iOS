//
//  ObserveTaskViewTests.swift
//  ToDoListTests
//
//  Created by Анастасия Сиденко on 27.06.2022.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import ToDoList

class ObserveTaskViewTests: XCTestCase {

    func testObserveTaskView_high() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.high,
            isCompleted: true
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_low() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.low,
            isCompleted: true
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_middle() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_critical() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.critical,
            isCompleted: true
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_completed() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: true
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_notCompeted() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_description() throws {
        let task = TaskModel(
            title: "first",
            description: "some desription",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
    
    func testObserveTaskView_emptyDescription() throws {
        let task = TaskModel(
            title: "first",
            description: "",
            priority: PriorityModel.middle,
            isCompleted: false
        )
        
        let view = ObserveTaskView(task: task)
        let vc = UIHostingController(rootView: view)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr))
    }
}
