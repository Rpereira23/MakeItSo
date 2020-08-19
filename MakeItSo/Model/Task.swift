//
//  Task.swift
//  MakeItSo
//
//  Created by Rick on 8/18/20.
//  Copyright © 2020 Rick. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
    var title: String
    var completed: Bool
}
