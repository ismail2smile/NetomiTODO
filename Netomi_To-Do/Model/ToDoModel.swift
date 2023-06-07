//
//  ToDoModel.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import Foundation
import RealmSwift

enum Status: String {
    case pending
    case completed
}
class ToDo: Object {
    @Persisted var title: String
    @Persisted var status: String
    @Persisted var date: Date
    
    convenience init(title: String, status: Status, date :Date) {
        self.init()
        self.title = title
        self.status = status.rawValue
        self.date = date
    }
}
