//
//  TaskCellViewModel.swift
//  MakeItSo
//
//  Created by Rick on 8/18/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    
    var taskRepository = TaskRepository()
    
    @Published var task: Task
    @Published var completedStateIconName = ""
    var id = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map{ task in
                task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completedStateIconName, on: self)
        .store(in: &cancellables)
        
        
        $task.compactMap{ task in task.id }.assign(to: \.id, on: self).store(in: &cancellables)
        
        $task
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
            self.taskRepository.updateTask(task)
        }
        .store(in: &cancellables)
    }
    
    
    
    
    
}
