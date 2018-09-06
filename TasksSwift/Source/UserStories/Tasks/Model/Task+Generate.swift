//
//  Task+Generate.swift
//  TasksSwift
//
//  Created by Rafael Kayumov on 06.09.2018.
//  Copyright © 2018 Cultured Code GmbH & Co. KG. All rights reserved.
//

import Foundation

extension Task {

    static func generateList() -> [Task] {
        guard let mockURL = Bundle.main.url(forResource: "TasksListMock", withExtension: "json"),
        let jsonData = try? Data(contentsOf: mockURL) else { return [] }

        let tasks = try? JSONDecoder().decode([Task].self, from: jsonData)
        return tasks ?? []
    }
}
