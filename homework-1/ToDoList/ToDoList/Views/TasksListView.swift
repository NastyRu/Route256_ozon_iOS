//
//  TasksListView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct TasksListView: View {
    
    @EnvironmentObject var listViewModel: TaskViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.tasks.isEmpty {
                Text("Ты молодец!😎\nСделал все задачи, добавляй новые!")
                    .font(.system(size: 30).bold())
                    .multilineTextAlignment(.center)
            } else {
                List {
                    ForEach(listViewModel.tasks) { task in
                        NavigationLink {
                            ObserveTaskView(task: task)
                        } label: {
                            TasksListItemView(task: task)
                        }
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                }
                .listStyle(PlainListStyle())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationTitle("Список задач")
        .navigationBarItems(
            trailing:
                NavigationLink("Добавить", destination: CreateTaskView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TasksListView()
        }
        .environmentObject(TaskViewModel())
    }
}
