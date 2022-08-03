//
//  AddToDoViewController.swift
//  Custom Todo
//
//  Created by Pierpaolo Mariani on 18/07/22.
//

import RealmSwift
import UIKit

class AddToDoViewController: UIViewController {
//    create view objects
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    var passedDateString  : String?
    
//    make reference for the first view controller
    var viewController : ViewController?=nil
    

    //    create database instance
        let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController?.retrieveData()
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
//        conforming the date to string Type
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY  H/mm"
        let dateString = dateFormatter.string(from: datePicker.date)
        print(dateString)
        passedDateString = dateString 
     
    }
    
    
    func saveData(object : Todo) {
      try!  realm.write {
            realm.add(object)
      }
    }
    
    func createNewTodo() {
        //   create and add New element in our collection of ToDo
        let newToDo = Todo()
        newToDo.priority = segmentedController.selectedSegmentIndex
        let text = textfield.text
        newToDo.text = text!
        let tag = tagTextField.text
        newToDo.tag = tag!
        newToDo.date = passedDateString ?? ""
        viewController?.todos.append(newToDo)
        saveData(object: newToDo)
    }
    
    

    @IBAction func doneButtonTapped(_ sender: Any) {
        createNewTodo()
        self.viewController?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
}
