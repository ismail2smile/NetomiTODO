//
//  AddTodoViewModel.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 07/06/23.
//

import Foundation
import RealmSwift


protocol AddViewModelProtocol {
    var repo: AddTodoRepositoryProtocol { get set }
    func saveTodo(todo: ToDo)
}

final class AddTodoViewModel: AddViewModelProtocol {
    var repo: AddTodoRepositoryProtocol
    
    init(repo: AddTodoRepositoryProtocol) {
        self.repo = repo
    }
    
    func saveTodo(todo: ToDo) {
        repo.saveTodo(todo: todo)
    }
}
