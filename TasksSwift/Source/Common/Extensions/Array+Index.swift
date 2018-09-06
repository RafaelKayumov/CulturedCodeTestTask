//
//  Array+Index.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

extension Array where Array.Element: AnyObject {

    func index(ofElement element: Element) -> Int? {
        for (currentIndex, currentElement) in self.enumerated() {
            if currentElement === element {
                return currentIndex
            }
        }
        return nil
    }
}
