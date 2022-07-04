//
//  EditTaskView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct EditTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: TaskViewModel
    let task: TaskModel
    @State var titleText: String = ""
    @State var correctTitle: Bool = false
    @State var descriptionText: String = ""
    @State var isCompleted: Bool = false
    @State var priority: String = ""
    var priorities = ["Низкий", "Средний", "Высокий", "Критический"]
    
    @ViewBuilder
    fileprivate func input(withTitle: String, text: String, bindingText: Binding<String>) -> some View {
        HStack {
            Text(withTitle)
            Spacer()
            TextField(text, text: bindingText)
                .onAppear {
                    self.titleText = task.title
                }
                .padding(5)
                .frame(maxWidth: 180)
                .background(.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
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
        let bindingTitle = Binding<String>(get: {
            self.titleText
        }, set: {
            self.titleText = $0
            checkTitle()
        })
        
        ZStack {
            VStack(spacing: 30) {
                input(
                    withTitle: "Задача",
                    text: "Введите текст",
                    bindingText: bindingTitle
                )
                    .onAppear {
                        self.titleText = task.title
                    }
                
                input(
                    withTitle: "Описание",
                    text: "Введите текст",
                    bindingText: $descriptionText
                )
                    .onAppear {
                        self.descriptionText = task.description
                    }
                
                VStack {
                    HStack {
                        Text("Приоритет")
                        Spacer()
                    }
                    Picker("Приоритет задачи", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onAppear {
                        self.priority = task.priority.rawValue
                    }
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
                    Toggle(isOn: $isCompleted, label: {})
                        .onAppear {
                            self.isCompleted = task.isCompleted
                        }
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
                    Button {
                        listViewModel.updateTask(
                            task: TaskModel(
                                id: task.id,
                                title: titleText,
                                description: descriptionText,
                                priority: PriorityModel(rawValue: priority) ?? PriorityModel.middle,
                                isCompleted: isCompleted
                            )
                        )
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Сохранить")
                            .foregroundColor(.green)
                            .frame(minWidth: 0, maxWidth: 100, minHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    }
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Отменить")
                            .foregroundColor(.red)
                            .frame(minWidth: 0, maxWidth: 100, minHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                    }
                }
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
    
    func checkTitle() {
        if titleText.count > 0 {
            correctTitle = true
        } else {
            correctTitle = false
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var task1 = TaskModel(
        title: "first",
        description: "some desription",
        priority: PriorityModel.low,
        isCompleted: true
    )
    
    static var previews: some View {
        NavigationView {
            EditTaskView(task: task1)
        }
        .environmentObject(TaskViewModel(userDefaultsService: UserDefaultsService(key: "tasks_list")))
        .previewInterfaceOrientation(.portrait)
    }
}


