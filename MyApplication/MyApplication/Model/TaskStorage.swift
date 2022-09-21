//
//  TaskStorage.swift
//  MyApplication
//
//  Created by Nikita Skripka on 09.05.2022.
//

import Foundation

//Протокол описывающий сущность хранилище задач
protocol TaskStorageProtocol {
    
    func loadTask() -> [TaskProtocol]
    func saveTask(_ tasks: [TaskProtocol])
}

//Сущность хранилище данных
class TaskStorage: TaskStorageProtocol {
    
    private var storage = UserDefaults.standard
    var storageKey = "tasks"
    
    private enum TaskKey: String {
        case title
        case type
        case status
    }
    
    func loadTask() -> [TaskProtocol] {
        var resultTasks: [TaskProtocol] = []
        let taskFromStorage = storage.object(forKey: storageKey) as? [[String: String]] ?? []
        for task in taskFromStorage {
            guard let title = task[TaskKey.title.rawValue],
                  let typeRaw = task[TaskKey.type.rawValue],
                  let statusRaw = task[TaskKey.status.rawValue] else {
                continue
            }
            let type: TaskPriority = typeRaw == "important" ? .important : .normal
            let status: TaskStatus = statusRaw == "planed" ? .planned : .complited
            resultTasks.append(Task(title: title, type: type, status: status))
            
        }
        return resultTasks
    }
    
    func saveTask(_ tasks: [TaskProtocol]) {
        var arrayForStorage: [[String:String]] = []
        tasks.forEach{ task in
        var newElementForStorage: [String: String] = [:]
            newElementForStorage[TaskKey.title.rawValue] = task.title
            newElementForStorage[TaskKey.type.rawValue] = (task.type == .important) ? "important" : "normal"
            newElementForStorage[TaskKey.status.rawValue] = (task.status == .planned) ? "planned" : "complited"
            arrayForStorage.append(newElementForStorage)
        }
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
