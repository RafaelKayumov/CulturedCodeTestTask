//
//  TasksTableViewController.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation
import UIKit


class TasksTableViewController : UITableViewController {

    var tasks: NSArray?

    init(withTasks: NSArray) {

        super.init(style: UITableViewStyle.plain)

        self.title = "Tasks"
        self.tasks = withTasks
        self.toolbarItems = [UIBarButtonItem.init(title: "complete all",
                                                  style: UIBarButtonItemStyle.plain,
                                                  target: self,
                                                  action: #selector(TasksTableViewController.completeAll)),
                             UIBarButtonItem.init(title: "sort by name",
                                                  style: UIBarButtonItemStyle.plain,
                                                  target: self,
                                                  action: #selector(TasksTableViewController.sort))]

        self.tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell

        cell.configureStyle()
        cell.task = self.tasks?.object(at: indexPath.row) as! TSTask?

        let task = self.tasks?.object(at: indexPath.row) as! TSTask
        if (task.childrenTasks.count  > 0) {
            cell.accessoryType = .detailDisclosureButton
        }
        else if !(task.childrenTasks.count > 0) {
            cell.accessoryType = .none
        }

        if task.completed() {
            cell.setInactive()
        }

        return cell
    }


    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let taskCell = cell as! TaskCell
        taskCell.task?.switchDone()

        if (taskCell.task?.completed())! {
            taskCell.setInactive()
        }
        else {
            cell?.textLabel?.textColor = UIColor.init(white: 0, alpha: 1)
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskCell?
        let tvc = TasksTableViewController.init(withTasks: cell!.task!.childrenTasks)
        tvc.title = cell!.task!.title
        self.navigationController?.pushViewController(tvc, animated: true)
    }

    @objc func completeAll() {

        for cell in self.tableView.visibleCells {

            if let taskCell = cell as? TaskCell {
                if !(taskCell.task?.completed())! {
                    taskCell.setInactive()
                    taskCell.task?.switchDone()
                }
            }
        }
    }

    @objc func sort() {
        if let sorted = self.tasks?.sortedArray(using: #selector(getter: TSTask.title)) {
            self.tasks = NSArray.init(array: sorted)
        }

        // TODO: For some reason this doesn't animate...
        self.tableView.reloadData()
    }
}
