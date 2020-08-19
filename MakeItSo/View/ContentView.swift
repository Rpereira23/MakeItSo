//
//  ContentView.swift
//  MakeItSo
//
//  Created by Rick on 8/18/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var taskListVM = TaskListViewModel()
    
    @State var presentAddNewTask = false
    @State var showSignIn = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    
                    if presentAddNewTask {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewTask.toggle()
                            
                        }
                    }
                }
                
                Button(action: { self.presentAddNewTask.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Add new task.")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignIn, content: { SignInView() })
            .navigationBarItems(trailing:
                Button(action: { self.showSignIn.toggle() }) {
                    Image(systemName: "person.circle")
                })
            .navigationBarTitle("Tasks")
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> Void = {_ in}
    
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
            }
            TextField("Enter Task..." , text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
                
            })
        }
        
    }
    
}
