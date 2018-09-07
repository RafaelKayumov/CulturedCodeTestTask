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
    private var updatedAt: Date?

    private (set) var completed = false {
        didSet {
            guard oldValue != completed else { return }
            applyUpdateDate()
        }
    }

    var title: String {
        didSet {
            guard oldValue != title else { return }
            applyUpdateDate()
        }
    }

    init(title: String) {
        self.title = title
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        completed = try values.decode(Bool.self, forKey: .completed)
        title = try values.decode(String.self, forKey: .title)
        childrenTasks = try? values.decode([Task].self, forKey: .childrenTasks)

        childrenTasks?.forEach { $0.parentTask = self }
    }

    enum CodingKeys: String, CodingKey {
        case title
        case completed
        case childrenTasks = "children"
    }
}

// tree behaviour
private extension Task {

    func setChildrenCompletionRecursively(_ completed: Bool) {
        childrenTasks?.forEach {
            guard $0.completed != completed else { return }
            $0.completed = completed
            $0.setChildrenCompletionRecursively(completed)
        }
    }

    func updateParentCompletionRecursively() {
        guard let parentTask = parentTask, parentTask.childrenTasks?.isEmpty == false else { return }
        parentTask.applyComletionStatusAccordingToChildrenStatus()
    }

    func allChildrenTasksCompleted() -> Bool {
        return childrenTasks?.filter { $0.completed != true }.isEmpty == true
    }

    func applyComletionStatusAccordingToChildrenStatus() {
        completed = allChildrenTasksCompleted()
    }
}

private extension Task {

    func applyUpdateDate() {
        updatedAt = Date()
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

    func switchCompleted() {
        setCompleted(!completed)
    }

    func setCompleted(_ completed: Bool) {
        self.completed = completed
        updateParentCompletionRecursively()
        setChildrenCompletionRecursively(completed)
    }

    var updatedAtString: String {
        return updatedAt?.asString() ?? "not yet modified"
    }
}
