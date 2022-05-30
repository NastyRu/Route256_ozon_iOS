//
//  ObserveTaskView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct ObserveTaskView: View {
    
    let task: TaskModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                HStack {
                    Text("Задача")
                    Spacer()
                    Text(task.title)
                }
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
                )
                
                HStack {
                    Text("Описание")
                    Spacer()
                    Text(task.description)
                }
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
                )
                
                HStack {
                    Text("Приоритет")
                    Spacer()
                    Text(task.priority.rawValue)
                }
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
                )
                
                HStack {
                    Text("Статус")
                    Spacer()
                    Text(task.isCompleted ? "Выполнено": "Не выполнено")
                }
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                    .fill(Color.white)
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
        .environmentObject(TaskViewModel())
        .previewInterfaceOrientation(.portrait)
    }
}

