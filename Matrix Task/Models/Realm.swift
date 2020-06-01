//
//  Realm.swift
//  Matrix Task
//
//  Created by Veranika Razdabudzka on 6/1/20.
//  Copyright © 2020 Veranika Razdabudzka. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class RealmTaskDoFirst {
    static func save( _ task:TaskDoFirst) {
        try! realm.write{
            realm.add(task)
        }
    }
}

class RealmTaskSchedule {
    static func save( _ task:TaskSchedule) {
        try! realm.write{
            realm.add(task)
        }
    }
}

class RealmTaskDelegate {
    static func save( _ task:TaskDelegate) {
        try! realm.write{
            realm.add(task)
        }
    }
}

class RealmTaskDelete {
    static func save( _ task:TaskDelete) {
        try! realm.write{
            realm.add(task)
        }
    }
}

