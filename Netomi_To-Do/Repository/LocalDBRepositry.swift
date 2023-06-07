//
//  LocalDBRepositry.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import Foundation
protocol LocalDBProtocol {
    var dataSource: RealmManagerProtocol { get set }
    
    func saveTodo(todo: ToDo)
    func fetchTaskWithFilter(filter:DB_Filter) -> [ToDo]
    func updateStatus(todo:ToDo, status:String)
    func deleteTodo(todo: ToDo)
    func getDatabaseURL() -> URL?
}


final class LocalDBRepository: LocalDBProtocol {
    
    var dataSource: RealmManagerProtocol
    
    init(dataSource: RealmManagerProtocol) {
        self.dataSource = dataSource
    }
    
    func saveTodo(todo: ToDo) {
        dataSource.saveTodo(todo: todo)
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
