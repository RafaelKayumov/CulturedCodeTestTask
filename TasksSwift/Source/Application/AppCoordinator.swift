//
//  AppCoordinator.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import UIKit

class AppCoordinator {

    private static var navigationController: UINavigationController?
    private static var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }

    static func setupUI() {
        setupMainWindow()

        let rootViewController = prepareRootViewController()
        let navigationController =  UINavigationController(rootViewController: rootViewController)
        navigationController.isToolbarHidden = false

        window?.rootViewController = navigationController
        self.navigationController = navigationController

        window?.makeKeyAndVisible()
    }

    private static func setupMainWindow() {
        (UIApplication.shared.delegate as? AppDelegate)?.window = UIWindow()
    }

    private static func prepareRootViewController() -> TasksTableViewController {
        let tasks = Task.generateList()
        return TasksTableViewController(tasks: tasks)
    }

    static func pushTasksViewControllerWithTasks(_ tasks: [Task], title: String) -> TasksTableViewController  {
        let tasksViewController = TasksTableViewController(tasks: tasks)
        tasksViewController.title = title
        navigationController?.pushViewController(tasksViewController, animated: true)
        return tasksViewController
    }
}
