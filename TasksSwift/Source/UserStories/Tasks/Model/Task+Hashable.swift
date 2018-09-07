//
//  Task+Hashable.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 07.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

extension Task: Hashable {
    var hashValue: Int {
        return title.hashValue
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.title == rhs.title
    }
}
