//
//  Array+Repositions.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 07.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

typealias Reposition = (oldIndex: Int, newIndex: Int)

extension Array where Array.Element: Hashable {

    func repositionsWithNewArray(_ array: Array) -> [Reposition]? {
        let currentSet = Set<Array.Element>(self)
        let newSet = Set<Array.Element>(array)
        guard currentSet == newSet else { return nil }
        return self.map {
            return Reposition(index(of: $0)!, array.index(of: $0)!)
        }
    }
}
