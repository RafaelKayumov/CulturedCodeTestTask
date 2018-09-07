//
//  TaskList.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 07.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import UIKit

class TaskList {

    private (set) var tasks: [Task]

    init(tasks: [Task]) {
        self.tasks = tasks
    }

    func completeAll() {
        tasks.forEach { $0.setCompleted(true) }
    }

    func sort() {
        tasks.sort { $0.title < $1.title }
    }
 }

extension TaskList {

    subscript(index: Int) -> Task? {
        get {
            guard tasks.indices.contains(index) else { return nil }
            return tasks [index]
        }
    }
}

