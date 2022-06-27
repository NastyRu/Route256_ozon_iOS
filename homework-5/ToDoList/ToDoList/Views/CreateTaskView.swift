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
    @State var descriptionText = ""
    @State var priority = "Средний"
    @State private var showingAlert = false
    var priorities = ["Низкий", "Средний", "Высокий", "Критический"]
    var isValidTitle: Bool {
       !titleText.isEmpty
    }
    
    @ViewBuilder
    fileprivate func input(withTitle: String, text: String, bindingText: Binding<String>) -> some View {
        VStack {
            HStack {
                Text(withTitle)
                Spacer()
            }
            TextField(text, text: bindingText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
        }
        .padding(.vertical)
    }
    
    var body: some View {
        let bindingTitle = Binding<String>(get: {
            self.titleText
        }, set: {
            self.titleText = $0
        })
        
        VStack {
            input(
                withTitle: "Название задачи *",
                text: "Введите текст",
                bindingText: bindingTitle
            )
            
            input(
                withTitle: "Описание",
                text: "Введите текст",
                bindingText: $descriptionText
            )
            
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
                    .foregroundColor(isValidTitle ? .white: Color(UIColor.secondaryLabel))
                    .font(.headline)
                    .frame(width: 100, height: 55)
                    .background(isValidTitle ? Color.accentColor: Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .disabled(!isValidTitle)
            }
        }
        .padding()
        .navigationTitle("Новая задача")
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Некорректное название задачи"),
                dismissButton: .cancel()
            )
        }
    }
    
    func saveButtonPressed() {
        if isValidTitle {
            listViewModel.addTask(
                title: titleText,
                description: descriptionText,
                priority: priority
            )
            presentationMode.wrappedValue.dismiss()
        } else {
            showingAlert = true
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTaskView()
        }
        .environmentObject(TaskViewModel(userDefaultsService: UserDefaultsService(key: "tasks_list")))
        .previewInterfaceOrientation(.portrait)
    }
}
