//
//  AddToDoViewController.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import UIKit
import Material

class AddToDoViewController: UIViewController {

    // MARK: - Properties
    var addTodoViewModel: AddTodoViewModel!
    var selectedDate : Date!
    // MARK: - UI Elements
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var dateTextField: TextField!
    var picker : UIDatePicker = UIDatePicker()

    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add ToDo"
        setupView()
        // Do any additional setup after loading the view.
    }
    

    func setupView(){
        setUpTextviewDelegate()
    }
    
    func setUpTextviewDelegate(){
        titleTextField.delegate = self
        dateTextField.delegate = self
    }
    // MARK: - Push to View
    @IBAction func cancelButtonAction(sender: UIButton?){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addButtonAction(sender: UIButton){
        if isValidToDo(){
            picker.removeFromSuperview()
            let todo = ToDo(title: titleTextField.text ?? "Unknown task", status: Status.pending, date: selectedDate)
            addTodoViewModel.saveTodo(todo: todo)
            cancelButtonAction(sender:  nil)
        }else{
            Utils.showAlert(title: Constants.errorAlertTitle, message: Constants.todoError_alertDescription, viewController: self)
        }
    }

    func isValidToDo() -> Bool{
        if titleTextField.text?.count ?? 0 > 0 && selectedDate != nil{
            return true
        }
        return false
    }
    
    
    func showDatePicker(){
        
        if selectedDate == nil{
            picker.datePickerMode = UIDatePicker.Mode.dateAndTime
            picker.minimumDate = Date(timeIntervalSinceNow: TimeInterval(15*60))
            picker.addTarget(self, action:#selector(pickerDateChanged(_:)), for: UIControl.Event.valueChanged)
            picker.frame = self.dateTextField.frame
            selectedDate = picker.date
            self.view.addSubview(picker)
        }
    }
    @objc func pickerDateChanged(_ datepicker: UIDatePicker) {
        selectedDate = datepicker.date
    }
    
    
}

extension AddToDoViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTextField{
            showDatePicker()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
