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

    func sort() -> [Reposition]? {
        let sorted = tasks.sorted { $0.title < $1.title }
        let repositions = tasks.repositionsWithNewArray(sorted)
        tasks = sorted
        return repositions
    }

    func indexForParentOfTask(_ task: Task) -> Int? {
        guard let parent = task.parentTask else { return nil }
        return tasks.index(ofElement: parent)
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

