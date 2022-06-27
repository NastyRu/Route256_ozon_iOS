//
//  ObserveTaskView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct ObserveTaskView: View {
    
    let task: TaskModel
    
    @ViewBuilder
    fileprivate func row(withTitle: String, text: String) -> some View {
        HStack {
            Text(withTitle)
            Spacer()
            Text(text)
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous
            )
            .fill(Color.white)
        )
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                row(withTitle: "Задача", text: task.title)
                row(withTitle: "Описание", text: task.description)
                row(withTitle: "Приоритет", text: task.priority.rawValue)
                row(
                    withTitle: "Статус",
                    text: task.isCompleted ? "Выполнено": "Не выполнено"
                )
                
                NavigationLink(
                destination: EditTaskView(task: task),
                label: {
                    Text("Редактировать")
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
                )
                
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .navigationTitle("Задача")
    }
}

struct ObserveTaskView_Previews: PreviewProvider {
    static var task1 = TaskModel(
        title: "first",
        description: "some desription",
        priority: PriorityModel.low,
        isCompleted: true
    )
    
    static var previews: some View {
        NavigationView {
            ObserveTaskView(task: task1)
        }
        .environmentObject(TaskViewModel(userDefaultsService: UserDefaultsService(key: "tasks_list")))
        .previewInterfaceOrientation(.portrait)
    }
}

