//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @StateObject var tasks: TaskViewModel = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TasksListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(tasks)
        }
    }
}
