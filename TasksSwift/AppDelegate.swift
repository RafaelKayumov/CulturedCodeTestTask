//
//  AppDelegate.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//
import UIKit

let kTitle = "title";
let kCompleted = "completed";
let kChildren = "children";


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tasksTableViewController: TasksTableViewController!
    var navigationController: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.tasksTableViewController = TasksTableViewController.init(withTasks: self._generateTasks())
        self.navigationController = UINavigationController.init(rootViewController: self.tasksTableViewController)
        self.navigationController.isToolbarHidden = false
        self.window?.rootViewController = self.navigationController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()

        return true
    }

    func _generateTasks() -> NSArray {
        let taskDescriptions = [
            [ kTitle : "Buy milk",
              kCompleted : false ],

            [ kTitle     : "Pay rent",
              kCompleted : false ],

            [ kTitle     : "Change tires",
              kCompleted : false ],

            [ kTitle     : "Sleep",
              kCompleted : false,
              kChildren  :
                [
                    [ kTitle     : "Find a bed",
                      kCompleted : false
                    ],

                    [ kTitle     : "Lie down",
                      kCompleted : false
                    ],

                    [ kTitle     : "Close eyes",
                      kCompleted : false
                    ],

                    [ kTitle     : "Wait",
                      kCompleted : false
                    ]
                ] ],

            [ kTitle     : "Dance",
              kCompleted : false ],

            ]

        return _taskFromDescriptions(taskDescriptions)
    }

    func _taskFromDescriptions(_ descriptions: Array<[String:Any]>) -> NSArray {
        let tasks = NSMutableArray.init()

        for taskDescription in descriptions {
            let title = taskDescription[kTitle] as! String
            let completed = taskDescription[kCompleted] as! Bool
            let childrenDescriptions = taskDescription[kChildren] as! Array<[String:Any]>?

            let task = TSTask.initWith(title: title)
            task.childrenTasks = NSMutableArray.init(array: [])
            if completed != task.completed() { task.switchDone() }

            if childrenDescriptions != nil && childrenDescriptions!.count > 0 {
                let children = self._taskFromDescriptions(childrenDescriptions!)
                for child in children {
                    task.addChild(child: child as! TSTask)
                    NSLog("adding")
                }
            }

            tasks.addObjects(from: [task])
        }

        return tasks
    }
}
