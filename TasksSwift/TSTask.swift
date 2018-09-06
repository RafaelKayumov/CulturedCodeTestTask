//
//  TSTask.swift
//  TasksSwift
//
//  Created by Jace on 8/5/18.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

func now() -> Date {
    return NSDate() as Date
}

class TSTask
{

    private var modified: NSDate!;    var done: Bool = false
    var parentTask: Any?

    init() {
        title = "<no title>";
//        modified = 0; //??
    }

    class func initWith(title name: String) -> TSTask {
        let task = TSTask.init()
        task.title = name

        return task
    }

    deinit {
        title = nil
        childrenTasks.removeAllObjects();
    }

    @objc var title: String? {
        didSet {
            modified = now() as NSDate
        }
    }

    var modifieddate: Date {
        get {
            return self.modified as Date
        }
    }
    var modifiedString: String {
        get {
            let cal = Calendar.init(identifier: .gregorian)
            var ret: String?

            if (!(modified==nil)) {
                let f: DateFormatter = DateFormatter.init()
                f.calendar = cal
                ret = f.string(from: modified! as Date)
            } else {
                return "not yet moidfied"
            }

            return ret!;
        }
    }

    var childrenTasks: NSMutableArray = NSMutableArray.init()

    func addChild(child: TSTask) { modified = now() as NSDate
        childrenTasks.addObjects(from: [child])
        child.parentTask = self
    }

    func removeChild(child: TSTask) {
        childrenTasks.remove(child)
    }


    // MARK - completed

    func completed() -> Bool
    {
        if done { return true}
        else      {return false;}
    }
    var notCompleted: Bool {
        get {
        if (!done)  {
            return false}
        else { return true
        }
        }

    }


    func switchDone(){
        var newDone: Bool = false
        if done
        { done = newDone }
        else
        { newDone = true }

        done = newDone
    }

    func makeAllChildrenComplete() {
        for l in 1...childrenTasks.count {
            let task = childrenTasks.object(at: l) as! TSTask
            if task.notCompleted {
                let task = childrenTasks.object(at: 1) as! TSTask
                task.switchDone()
            }}
    }




    func deleteChildren() {
        for l in 0...childrenTasks.count {
            childrenTasks.removeObject(at: l)
        }
    }
}



