//
//  RealmManager.swift
//  Мой день
//
//  Created by Nikita Skripka on 01.09.2022.
//
import UIKit
import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    //ScheduleModel
    func saveScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    //TasksModel
    func saveTasksModel(model: TasksModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTasksModel(model: TasksModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TasksModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    }
    
    //ContactModel
    func saveContactModel(model: ContactModel) {
        try! localRealm.write{
            localRealm.add(model)
        }
    }
    
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateContactModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactMail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactImage = imageData
        }
    }
}

