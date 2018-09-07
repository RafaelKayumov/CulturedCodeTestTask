//
//  UITableView+Repositions.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 07.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import UIKit

extension UITableView {

    func performRepositions(_ repositions: [Reposition]) {
        performBatchUpdates({
            repositions.forEach {
                let oldIndexPath = IndexPath(row: $0.0, section: 0)
                let newIndexPath = IndexPath(row: $0.1, section: 0)
                moveRow(at: oldIndexPath, to: newIndexPath)
            }
        }, completion: nil)
    }
}
