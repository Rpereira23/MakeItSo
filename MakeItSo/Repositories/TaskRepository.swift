//
//  TaskRepository.swift
//  MakeItSo
//
//  Created by Rick on 8/18/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    private let collectionPath = "Tasks"
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        
        
        db.collection(collectionPath)
        .order(by: "createdTime")
        .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        return x
                        
                    } catch {
                        print(error)
                    }
                    return nil
                }
            }
            
        }
    }
    
    
    func addTask(_ task: Task) {
        do {
            let _ = try db.collection(collectionPath).addDocument(
                from: Task(
                id: task.id,
                createdTime: task.createdTime,
                userId: Auth.auth().currentUser?.uid,
                title: task.title,
                completed: task.completed))
        } catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task) {
        if let taskID = task.id {
            do {
                try db.collection(collectionPath).document(taskID).setData(from: task)
            } catch {
                fatalError("[updateTask] Failed to encode: \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
