//
//  TasksTableViewController.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation
import UIKit

private let kTaskCellIdentifier = "TaskCell"

protocol TasksTableViewControllerDelegate: AnyObject {

    func tasksTableViewControllerDidSwitchCompletionForTask(_ task: Task)
    func tasksTableViewControllerDidSwitchCompletionForTasks(_ tasks: [Task])
}

class TasksTableViewController : UITableViewController {

    private var taskList: TaskList
    weak var delegate: TasksTableViewControllerDelegate?

    init(tasks: [Task]) {
        taskList = TaskList(tasks: tasks)
        super.init(style: .plain)
        
        title = "Tasks"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Storyboard not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 1))

        setupToolbar()
        registerCells()
    }
}

private extension TasksTableViewController {

    func setupToolbar() {
        let completeAllItem = UIBarButtonItem(title: "complete all", style: .plain, target: self, action: #selector(completeAll))
        let sortByNameItem = UIBarButtonItem(title: "sort by name", style: .plain, target: self, action: #selector(sort))
        toolbarItems = [completeAllItem, sortByNameItem]
    }

    func registerCells() {
        tableView.register(TaskCell.self, forCellReuseIdentifier: kTaskCellIdentifier)
    }

    @objc func completeAll() {
        taskList.completeAll()
        tableView.reloadData()
        delegate?.tasksTableViewControllerDidSwitchCompletionForTasks(taskList.tasks)
    }

    @objc func sort() {
        guard let repositions = taskList.sort() else { return }
        tableView.performRepositions(repositions)
    }

    func toggleTaskForCellAtIndexPath(_ indexPath: IndexPath) {
        let index = indexPath.row
        guard let task = taskList[index] else { return }
        task.switchCompleted()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        delegate?.tasksTableViewControllerDidSwitchCompletionForTask(task)
    }
}

extension TasksTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTaskCellIdentifier, for: indexPath) as! TaskCell

        let index = indexPath.row
        if let task = taskList[index] {
            cell.setupWithTask(task)
        }

        return cell
    }
}

extension TasksTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        toggleTaskForCellAtIndexPath(indexPath)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let task = taskList[indexPath.row], task.childrenTasks?.isEmpty == false else { return }
        let tasksViewController = AppCoordinator.pushTasksViewControllerWithTasks(task.childrenTasks!, title: task.title)
        tasksViewController.delegate = self
    }
}

extension TasksTableViewController: TasksTableViewControllerDelegate {

    func tasksTableViewControllerDidSwitchCompletionForTask(_ task: Task) {
        guard let index = taskList.indexForParentOfTask(task) else { return }
        tableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)

        if let delegate = self.delegate, let task = taskList[index] {
            delegate.tasksTableViewControllerDidSwitchCompletionForTask(task)
        }
    }

    func tasksTableViewControllerDidSwitchCompletionForTasks(_ tasks: [Task]) {
        guard let parents = taskList.existingParentsForTasks(tasks) else { return }
        let indexPaths = parents.compactMap { parent -> IndexPath? in
            guard let index = taskList.tasks.index(of: parent) else { return nil }
            return IndexPath(row: index, section: 0)
        }

        tableView.reloadRows(at: indexPaths, with: .automatic)

        if let delegate = self.delegate {
            delegate.tasksTableViewControllerDidSwitchCompletionForTasks(parents)
        }
    }
}
