//
//  Tasks.swift
//  ME
//
//  Created by Veranika Razdabudzka on 11/4/20.
//

import Foundation
import RealmSwift

class DoNowTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var note: String?
    @objc dynamic var date: String?
    @objc dynamic var done = false
}

class ScheduleTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var note: String?
    @objc dynamic var date: String?
    @objc dynamic var done = false
}

class DelegateTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var note: String?
    @objc dynamic var date: String?
    @objc dynamic var done = false
}

class DeleteTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var note: String?
    @objc dynamic var date: String?
    @objc dynamic var done = false
}
