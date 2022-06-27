//
//  TasksListItemView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct TasksListItemView: View {
    
    let task: TaskModel
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(task.title)
                        .font(.system(size: 20).bold())
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text(task.description)
                        .font(.system(size: 20))
                        .lineLimit(1)
                    Spacer()
                }
            }
            
            switch task.priority {
            case PriorityModel.low:
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
            case PriorityModel.middle:
                Image(systemName: "equal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            case PriorityModel.high:
                Image(systemName: "chevron.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.orange)
            case PriorityModel.critical:
                Image(systemName: "flame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(.red)
            }
            
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .padding()
    }
}

struct TasksListItemView_Previews: PreviewProvider {
    
    static var task1 = TaskModel(
        title: "first",
        description: "some desription",
        priority: PriorityModel.low,
        isCompleted: true
    )
    static var task2 = TaskModel(
        title: "second",
        description: "very many words real long aaaaaaa some desription",
        priority: PriorityModel.middle,
        isCompleted: false
    )
    static var task3 = TaskModel(
        title: "third",
        description: "some desription",
        priority: PriorityModel.high,
        isCompleted: true
    )
    static var task4 = TaskModel(
        title: "forth",
        description: "very many words real long aaaaaaa some desription",
        priority: PriorityModel.critical,
        isCompleted: false
    )
    
    static var previews: some View {
        Group {
            TasksListItemView(task: task1)
            TasksListItemView(task: task2)
            TasksListItemView(task: task3)
            TasksListItemView(task: task4)
        }
        .previewLayout(.sizeThatFits)
    }
}
