//
//  Realm.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class SaveDoNowTask {
    static func save (_ tasks: DoNowTask) {
        try! realm.write{
            realm.add(tasks)
        }
    }
}

class SaveSchedule {
    static func save(_ tasks: ScheduleTask) {
        try! realm.write{
            realm.add(tasks)
        }
    }
}

class SaveDelegate {
    static func save(_ tasks: DelegateTask) {
        try! realm.write{
            realm.add(tasks)
        }
    }
}

class SaveDelete {
    static func save(_ tasks: DeleteTask) {
        try! realm.write{
            realm.add(tasks)
        }
    }
}

