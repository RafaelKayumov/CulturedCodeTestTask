//
//  Date+Formatting.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

extension Date {

    func asString(style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
