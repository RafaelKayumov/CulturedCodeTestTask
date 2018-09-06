//
//  Task.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

class Task: Decodable {

    private (set) var parentTask: Task?
    private (set) var childrenTasks: [Task]?

    var completed = false {
        didSet {
            guard oldValue != completed else { return }
            applyUpdateDate()
        }
    }
    private var updatedAt: Date?
    var title: String {
        didSet {
            guard oldValue != title else { return }
            applyUpdateDate()
        }
    }

    init(title: String) {
        self.title = title
    }

    enum CodingKeys: String, CodingKey {
        case title
        case completed
        case childrenTasks = "children"
    }
}

extension Task {

    func addChild(_ child: Task) {
        childrenTasks?.append(child)
    }

    func removeChild(_ child: Task) {
        guard let indexOfChild = childrenTasks?.index(ofElement: child) else { return }
        childrenTasks?.remove(at: indexOfChild)
    }

    func removeAllChildren() {
        childrenTasks?.removeAll()
    }

    func completeAllChildrenTasks() {
        childrenTasks?.filter { !$0.completed }.forEach { $0.completed = true }
    }

    func switchCompleted() {
        completed = !completed
    }

    var updatedAtString: String {
        return updatedAt?.asString() ?? "not yet moidfied"
    }
}

private extension Task {

    func applyUpdateDate() {
        updatedAt = Date()
    }
}
