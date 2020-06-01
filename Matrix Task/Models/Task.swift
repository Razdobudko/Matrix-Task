//
//  Task.swift
//  Matrix Task
//
//  Created by Veranika Razdabudzka on 6/1/20.
//  Copyright © 2020 Veranika Razdabudzka. All rights reserved.
//

import Foundation
import RealmSwift

class TaskDoFirst: Object {
    @objc dynamic var name = ""
    @objc dynamic var task: String?
    @objc dynamic var data: String?
}

class TaskSchedule: Object {
    @objc dynamic var name = ""
    @objc dynamic var task: String?
    @objc dynamic var data: String?
}

class TaskDelegate: Object {
    @objc dynamic var name = ""
    @objc dynamic var task: String?
    @objc dynamic var data: String?
}

class TaskDelete: Object {
    @objc dynamic var name = ""
    @objc dynamic var task: String?
    @objc dynamic var data: String?
}
