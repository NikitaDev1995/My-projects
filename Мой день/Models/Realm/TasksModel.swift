//
//  TasksModel.swift
//  Мой день
//
//  Created by Nikita Skripka on 07.09.2022.
//

import Foundation
import RealmSwift

class TasksModel: Object {
    
    @Persisted var tasksDate: Date?
    @Persisted var tasksLesson: String = "Unknown"
    @Persisted var tasksTask: String = "Unknown"
    @Persisted var tasksColor: String = "0433FF"
    @Persisted var taskReady: Bool = false
}
