//
//  ListTestCase.swift
//  Netomi_To-DoTests
//
//  Created by SPURGE on 07/06/23.
//

import XCTest
@testable import Netomi_To_Do

class ScreenLoadTests: XCTestCase {
    func loadListView() throws -> ListViewController {
        let window = UIWindow()
        let navCord = NavCoordinator()
        
        window.rootViewController = navCord.rootViewController
        navCord.showRootview()
        window.makeKeyAndVisible()
        
        let navcontroller = try XCTUnwrap(window.rootViewController as? UINavigationController )
        return try XCTUnwrap(navcontroller.topViewController as? ListViewController )
    }
    //MARK: -  List View Test
    func testViewdidload() throws{
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Task List")
    }

    func testSetUpTableViewDelegate()throws{
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        XCTAssertIdentical(sut.listTableView.delegate, sut)
        XCTAssertIdentical(sut.listTableView.dataSource, sut)
    }

    func testEmptyTableView()throws{
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.listTableView.numberOfRows(inSection: 0), 0)
    }
    
    func testDeleteAll_ToDo()throws{
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        sut.listViewModel.fetchTaskWithFilter(filter: DB_Filter.recent)
        
        for item in sut.listViewModel.todos{
            sut.listViewModel.deleteTodo(todo: item)
        }
    }
    
    //MARK: -  Add TODO Test
    func testPushToAddVC()throws -> AddToDoViewController{
        
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        
        let addTodoVC = DependencyInjector.addTodoViewcontroller
        sut.navigationController?.pushViewController(addTodoVC, animated: true)
        return addTodoVC
    }
    
    func testViewdidloadAddTodo()throws{
        let sut = try testPushToAddVC()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Add ToDo")
    }
    
    func testAddobjectToDB()throws{
        let todoItem = ToDo(title: "TEST T1", status: Status.pending, date: Date().addingTimeInterval(3600))
        let sut = try testPushToAddVC()
        sut.loadViewIfNeeded()
        sut.addTodoViewModel.saveTodo(todo: todoItem)
        sut.navigationController?.popViewController(animated: true)
    }
    //MARK: -  ListVC fetch and test data count
    func testListItemTableViewCount()throws{
        try testAddobjectToDB()
        let sut = try loadListView()
        sut.loadViewIfNeeded()
        sut.fetchAndReloadTable()
        XCTAssertEqual(sut.listTableView.numberOfRows(inSection: 0), 1)
    }
}


final class UtilsTests: XCTestCase {

    func testGetDateStringFromDate() {
        let date = Date(timeIntervalSince1970: 1622678400)
        let dateString = Utils.getDateStringFromDate(date: date)
        
        // Assert
        XCTAssertEqual(dateString, "03/06/21 05:30 AM")
    }
    
    func testGetTimeStringFromDate() {
        let date = Date(timeIntervalSince1970: 1622679500)
        let timeString = Utils.getTimeStringFromDate(date: date)
        
        // Assert
        XCTAssertEqual(timeString, "05:48 AM")
    }
    
    func testCompareDate() {
        
        let currentDate = Date()
        //  Item date is today
        let todayDate = currentDate.addingTimeInterval(3600)
        XCTAssertEqual(Utils.compareDate(itemDate: todayDate), .today)
        
        // Item date is in the past
        let pastDate = currentDate.addingTimeInterval(-3600) // 1 hour ago
        XCTAssertEqual(Utils.compareDate(itemDate: pastDate), .expired)

        // Item date is in the future
        let futureDate = currentDate.addingTimeInterval(3600 * 24) // 24 hour from now
        XCTAssertEqual(Utils.compareDate(itemDate: futureDate), .nextDay)
    }
}
