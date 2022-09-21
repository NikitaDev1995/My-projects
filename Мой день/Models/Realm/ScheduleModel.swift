//
//  ScheduleModel.swift
//  Мой день
//
//  Created by Nikita Skripka on 01.09.2022.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleType: String = "Unknown"
    @Persisted var scheduleBuilding: String = "Unknown"
    @Persisted var scheduleAudience: String = "Unknown"
    @Persisted var scheduleTeacher: String = "Unknown"
    @Persisted var scheduleColor: String = "0433FF"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
