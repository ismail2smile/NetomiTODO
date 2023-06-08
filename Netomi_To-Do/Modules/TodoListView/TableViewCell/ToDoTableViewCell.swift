//
//  ToDoTableViewCell.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import UIKit

protocol ToDoListCellDelegate {
    func changeTodoStatus(buttonTag: Int)
    func deleteTodoitem(buttonTag: Int)
}

class ToDoTableViewCell: UITableViewCell {

    //MARK: - Delegate
    var cellDelegate : ToDoListCellDelegate? = nil
    
    // MARK: - UI Elements
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction  func statusButtonAction(sender: UIButton){
        if cellDelegate != nil{
            cellDelegate?.changeTodoStatus(buttonTag: sender.tag)
        }
    }
    
    @IBAction  func deleteButtonAction(sender: UIButton){
        print("Delete task")
        if cellDelegate != nil{
            cellDelegate?.deleteTodoitem(buttonTag: sender.tag)
        }
    }
}
