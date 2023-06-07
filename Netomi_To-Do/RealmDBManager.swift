//
//  RealmDBManager.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import Foundation
import RealmSwift
enum DB_Filter: String{
    case recent
    case endDate
    case pending
}
protocol RealmManagerProtocol {
    func saveTodo(todo: ToDo)
    func fetchTaskWithFilter(filter:DB_Filter) -> [ToDo]
    func updateStatus(todo:ToDo, status:String)
    func deleteTodo(todo: ToDo)
    func getDatabaseURL() -> URL?
}


final class RealmLocalDataSource: RealmManagerProtocol {
    
    fileprivate let realm: Realm!
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func saveTodo(todo: ToDo) {
        do {
            try realm.write({
                realm.add(todo)
            })
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func fetchTaskWithFilter(filter:DB_Filter) -> [ToDo] {
        if filter.rawValue == DB_Filter.recent.rawValue{
            return realm.objects(ToDo.self).toArray().reversed()
        }else if filter.rawValue == DB_Filter.endDate.rawValue{
            return realm.objects(ToDo.self).sorted(byKeyPath: "date", ascending: true).toArray()
        }else{
            return realm.objects(ToDo.self).filter("status == %@",Status.pending.rawValue).sorted(byKeyPath: "date", ascending: true).toArray()
        }
    }
    
    func updateStatus(todo:ToDo, status:String) {
        do {
            try realm.write {
                todo.status = status
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTodo(todo: ToDo) {
        do {
            try realm.write({
                realm.delete(todo)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDatabaseURL() -> URL? {
        return realm.configuration.fileURL
    }
    
}


extension Results {
    func toArray<T>() -> [T] where T: Object {
        return self.map { $0 as! T }
    }
}

extension List {
    func toArray<T>() -> [T] where T: Object {
        return self.map { $0 as! T }
    }
}
