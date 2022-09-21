//
//  Task.swift
//  MyApplication
//
//  Created by Nikita Skripka on 09.05.2022.
//

import Foundation

enum TaskPriority {
    
    case normal
    case important
}

enum TaskStatus: Int {
    
    case planned
    case complited
    
}

//Протокол описывающий сущность задача
protocol TaskProtocol {
    
    var title: String { get set }
    var type: TaskPriority { get set }
    var status: TaskStatus { get set }
    
}
//Сущность задача
struct Task: TaskProtocol {
    
    var title: String
    var type: TaskPriority
    var status: TaskStatus
    
}
