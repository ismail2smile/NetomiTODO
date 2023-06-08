//
//  AddTodoRepositry.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 08/06/23.
//

import Foundation
protocol AddTodoRepositoryProtocol {
    var dataSource: RealmManagerProtocol { get set }
    func saveTodo(todo: ToDo)
    func getDatabaseURL() -> URL?
}


final class AddTodoRepository: AddTodoRepositoryProtocol {
    
    var dataSource: RealmManagerProtocol
    
    init(dataSource: RealmManagerProtocol) {
        self.dataSource = dataSource
    }
    
    func saveTodo(todo: ToDo) {
        dataSource.saveTodo(todo: todo)
    }

    func getDatabaseURL() -> URL? {
        return dataSource.getDatabaseURL()
    }
    
    
}

