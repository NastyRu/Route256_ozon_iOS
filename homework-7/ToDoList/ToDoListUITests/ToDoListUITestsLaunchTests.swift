//
//  ToDoListUITestsLaunchTests.swift
//  ToDoListUITests
//
//  Created by Анастасия Сиденко on 10.07.2022.
//

import XCTest

class ToDoListUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUp() {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testLaunch() {
        snapshot("01NoTasks")
    }
    
    func testNewTask() {
        XCUIApplication().navigationBars["Список задач"].buttons["Добавить"].tap()
        snapshot("02NewTask")
    }
}
