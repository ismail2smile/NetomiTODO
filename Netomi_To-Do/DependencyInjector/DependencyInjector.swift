//
//  DependencyInjector.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import Foundation
import RealmSwift

struct DependencyInjector {
    static var todos = [ToDo]()
    static var realm = try! Realm()
    
    static var dataSource: RealmManagerProtocol {
        return RealmLocalDataSource(realm: realm)
    }
    
    static var todoListrepo: ToDoListRepositoryProtocol {
        return ToDoListRepository(dataSource: self.dataSource)
    }
    
    static var listViewModel: ListViewModel {
        return ListViewModel(todos: self.todos, repo: self.todoListrepo)
    }
    
    static var rootViewController: ListViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let listVC = storyBoard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listVC.listViewModel = self.listViewModel
        return listVC
    }
    
    static var addTodoRepo: AddTodoRepositoryProtocol {
        return AddTodoRepository(dataSource: self.dataSource)
    }
    static var addTodoViewModel: AddTodoViewModel {
        return AddTodoViewModel(repo: self.addTodoRepo)
    }
    
    static var addTodoViewcontroller: AddToDoViewController {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let todoVC = storyBoard.instantiateViewController(withIdentifier: "AddToDoViewController") as! AddToDoViewController
        todoVC.addTodoViewModel = self.addTodoViewModel
        return todoVC
    }
}
