//
//  CreateTaskView.swift
//  ToDoList
//
//  Created by Анастасия Сиденко on 30.05.2022.
//

import SwiftUI

struct CreateTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: TaskViewModel
    @State var titleText = ""
    @State var correctTitle: Bool = false
    @State var descriptionText = ""
    @State var priority = "Средний"
    var priorities = ["Низкий", "Средний", "Высокий", "Критический"]
    
    var body: some View {
        let bindingTitle = Binding<String>(get: {
            self.titleText
        }, set: {
            self.titleText = $0
            checkTitle()
        })
        
        VStack {
            VStack {
                HStack {
                    Text("Название задачи *")
                    Spacer()
                }
                TextField("Введите текст", text: bindingTitle)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
            VStack {
                HStack {
                    Text("Описание")
                    Spacer()
                }
                TextField("Введите текст", text: $descriptionText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
            .padding(.vertical)
            
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
            }
            .padding(.vertical)
            
            Spacer()
            
            Text("* - обязательные поля для заполнения")
                .foregroundColor(Color(UIColor.secondaryLabel))
            Button {
                saveButtonPressed()
            } label: {
                Text("Добавить")
                    .foregroundColor(correctTitle ? .white: Color(UIColor.secondaryLabel))
                    .font(.headline)
                    .frame(width: 100, height: 55)
                    .background(correctTitle ? Color.accentColor: Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Новая задача")
    }
    
    func saveButtonPressed() {
        if correctTitle {
            listViewModel.addTask(
                title: titleText,
                description: descriptionText,
                priority: priority
            )
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func checkTitle() {
        if titleText.count > 0 {
            correctTitle = true
        } else {
            correctTitle = false
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTaskView()
        }
        .environmentObject(TaskViewModel())
        .previewInterfaceOrientation(.portrait)
    }
}
