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

class TasksTableViewController : UITableViewController {

    private var taskList = TaskList(tasks: [])

    init(tasks: [Task]) {
        taskList = TaskList(tasks: tasks)

        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 1))

        setupTitle()
        setupToolbar()
        registerCells()
    }
}

private extension TasksTableViewController {

    func setupTitle() {
        title = "Tasks"
    }

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
    }

    @objc func sort() {
        taskList.sort()
        tableView.reloadData()
    }

    func toggleTaskForCellAtIndexPath(_ indexPath: IndexPath) {
        let index = indexPath.row
        guard let task = taskList[index] else { return }
        task.switchCompleted()
        tableView.reloadRows(at: [indexPath], with: .automatic)
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
        AppCoordinator.pushTasksViewControllerWithTasks(task.childrenTasks!, title: task.title)
    }
}
