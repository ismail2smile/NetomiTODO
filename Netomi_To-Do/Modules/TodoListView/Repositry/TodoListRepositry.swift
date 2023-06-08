//
//  TodoListRepositry.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 08/06/23.
//


import Foundation
protocol ToDoListRepositoryProtocol {
    var dataSource: RealmManagerProtocol { get set }
    
    func fetchTaskWithFilter(filter:DB_Filter) -> [ToDo]
    func updateStatus(todo:ToDo, status:String)
    func deleteTodo(todo: ToDo)
    func getDatabaseURL() -> URL?
}


final class ToDoListRepository: ToDoListRepositoryProtocol {
    
    var dataSource: RealmManagerProtocol
    
    init(dataSource: RealmManagerProtocol) {
        self.dataSource = dataSource
    }
    
    func fetchTaskWithFilter(filter:DB_Filter) -> [ToDo] {
        return dataSource.fetchTaskWithFilter(filter:filter)
    }
    
    func updateStatus(todo:ToDo, status:String) {
        dataSource.updateStatus(todo:todo, status:status)
    }
    
    func deleteTodo(todo: ToDo) {
        dataSource.deleteTodo(todo: todo)
    }
    
    func getDatabaseURL() -> URL? {
        return dataSource.getDatabaseURL()
    }
    
    
}

