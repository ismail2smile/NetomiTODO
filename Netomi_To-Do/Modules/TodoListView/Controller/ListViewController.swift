//
//  ListViewController.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import UIKit


class ListViewController: UIViewController {

    // MARK: - Properties
    
    var listViewModel: ListViewModel!
    
    // MARK: - UI Elements
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var filterSegment: UISegmentedControl!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task List"
        setupView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAndReloadTable()
    }
    
    func setupView(){
        setUpTableViewDelegate()
        registerTableCells()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        filterSegment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        filterSegment.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    func setUpTableViewDelegate(){
        listTableView.dataSource = self
        listTableView.delegate = self
    }
    func registerTableCells(){
        self.listTableView.register(UINib(nibName: "ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")
    }
    
    func fetchAndReloadTable(){
        if filterSegment.selectedSegmentIndex == 0{
            listViewModel.fetchTaskWithFilter(filter: DB_Filter.recent)
        }else if filterSegment.selectedSegmentIndex == 1{
            listViewModel.fetchTaskWithFilter(filter: DB_Filter.endDate)
        }else{
            listViewModel.fetchTaskWithFilter(filter: DB_Filter.pending)
        }
        
        listTableView.reloadData()
    }

    // MARK: - Push to View
    @IBAction func addToDoAction(sender: UIButton?){
        let vc = DependencyInjector.addTodoViewcontroller
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func filterSegmentAction(sender: UISegmentedControl){
        fetchAndReloadTable()
    }
    
}

// MARK: - Table DataSource
extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell else {
               fatalError("Unable to dequeue ToDoTableViewCell")
           }
        
        let row = indexPath.row
        cell.statusButton.tag = row
        cell.deleteButton.tag = row
        let item = listViewModel.todos[row]
        
        cell.cellDelegate = self
        cell.titleLabel.text = item.title
        cell.titleLabel.textColor = .black
        
        cell.titleLabel.fontSize = 15
        cell.statusLabel.text = item.status
        cell.timeLabel.textColor = .black
        
        let itemOfday = Utils.compareDate(itemDate: item.date)
        if itemOfday == DateDisplayFormat.expired || itemOfday == DateDisplayFormat.nextDay{
            cell.timeLabel.text = Utils.getDateStringFromDate(date: item.date)
            cell.timeLabel.fontSize = 12
        }else if itemOfday == DateDisplayFormat.today{
            cell.timeLabel.text = Utils.getTimeStringFromDate(date: item.date)
            cell.timeLabel.fontSize = 13
        }
        
        if itemOfday == DateDisplayFormat.expired && item.status == Status.pending.rawValue{
            cell.titleLabel.textColor = .red
            cell.timeLabel.textColor = .red
            
        }
        if item.status == Status.completed.rawValue{
            cell.statusButton.setImage(UIImage(named: "check"), for: .normal)
        }else{
            cell.statusButton.setImage(UIImage(named: "uncheck"), for: .normal)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
// MARK: - Table Delagate

extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIView(frame: CGRect(x: 0, y: 10, width: tableView.frame.size.width, height: 20))
        tempView.cornerRadius = 7
        tempView.borderWidth = 1
        tempView.borderColor = .white
        tempView.backgroundColor = .white
        return tempView;

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView(frame: CGRect(x: 0, y: 10, width: tableView.frame.size.width, height: 20))
        tempView.cornerRadius = 7
        tempView.borderWidth = 1
        tempView.borderColor = .white
        tempView.backgroundColor = .white
        return tempView;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    
        return 20
    }
}

extension ListViewController : ToDoListCellDelegate{
    func changeTodoStatus(buttonTag: Int) {
        let item = listViewModel.todos[buttonTag]
        
        if item.status == Status.pending.rawValue{
            listViewModel.updateStatus(todo: item, status: Status.completed.rawValue)
        }else{
            listViewModel.updateStatus(todo: item, status: Status.pending.rawValue)
        }
        fetchAndReloadTable()
    }
    
    func deleteTodoitem(buttonTag: Int) {
        
        let tempItem = self.listViewModel.todos[buttonTag]
        let deleteDescription = String(format: Constants.delete_alertDescription, tempItem.title)

        let alertController = UIAlertController(title: Constants.warningAlertTitle, message: deleteDescription, preferredStyle: .alert)
            
        let cancelAction = UIAlertAction(title: Constants.cancelBtnTitle, style: .cancel) { _ in
                // Handle cancel action
            }
            
        let deleteAction = UIAlertAction(title: Constants.deleteBtnTitle, style: .destructive) { [weak self] _ in
                guard let self = self else { return } // Ensure self exists
                
                guard buttonTag < self.listViewModel.todos.count else { return } // Ensure buttonTag is within the valid range
                
                let item = self.listViewModel.todos[buttonTag]
                self.listViewModel.deleteTodo(todo: item)
                self.fetchAndReloadTable()
            }

            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
        if let viewController = self.navigationController?.topViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        
       
    }
}
