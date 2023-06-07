//
//  ListViewModel.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import Foundation
import RealmSwift
enum DateDisplayFormat: String{
    case today
    case expired
    case nextDay
}

protocol ListViewModelProtocol {
    var todos: [ToDo] { get set }
    var repo: LocalDBProtocol { get set }

    func fetchTaskWithFilter(filter:DB_Filter)
    func deleteTodo(todo: ToDo)
    func updateStatus(todo:ToDo, status:String)
}

final class ListViewModel: ListViewModelProtocol {
    
    var todos: [ToDo]
    var repo: LocalDBProtocol
    
    init(todos: [ToDo], repo: LocalDBProtocol) {
        self.todos = todos
        self.repo = repo
    }
    
    
    func fetchTaskWithFilter(filter:DB_Filter){
        self.todos = repo.fetchTaskWithFilter(filter: filter)
    }
    
    func deleteTodo(todo: ToDo) {
        repo.deleteTodo(todo: todo)
    }
    
    func updateStatus(todo:ToDo, status:String) {
        repo.updateStatus(todo:todo, status:status)
    }
    
}
