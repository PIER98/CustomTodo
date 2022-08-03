//
//  ToDoTableViewCell.swift
//  Custom Todo
//
//  Created by Pierpaolo Mariani on 25/07/22.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
//    create cell object
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var priorityView: UIView!
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priorityView.layer.cornerRadius = priorityView.layer.frame.height / 2
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
