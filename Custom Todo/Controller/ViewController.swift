//
//  ViewController.swift
//  Custom Todo
//
//  Created by Pierpaolo Mariani on 18/07/22.
//

import RealmSwift
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  , UISearchControllerDelegate , UISearchResultsUpdating {
//    create view objects
    @IBOutlet weak var tableView: UITableView!

//    model instance
    var todos : [Todo] = []
    
//    getting started with search
    let searchController = UISearchController(searchResultsController: nil)
    var searching = false
    var filteredTodo : [Todo] = []
    
    //    create database instance
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 90
        searchBarsetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
        self.tableView.reloadData()
    }
    
   func retrieveData()  {
   let savedTodo = try! realm.objects(Todo.self)
   self.todos.removeAll()
   self.todos.append(contentsOf: savedTodo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //    reference for second View Controller
        if let addTodoViewController = segue.destination as? AddToDoViewController {
            addTodoViewController.viewController = self
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.present(AddToDoViewController(), animated: true)
    }
    
    private func searchBarsetUp(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
//    edit tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredTodo.count
        }else {
            return todos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoTableViewCell
        if  !filteredTodo.isEmpty {
            cell?.toDoLabel?.text = filteredTodo[indexPath.row].text ?? ""
            cell?.dateLabel?.text = filteredTodo[indexPath.row].date
            cell?.tagLabel?.text =  filteredTodo[indexPath.row].tag
        } else {
            cell?.toDoLabel?.text = todos[indexPath.row].text
            cell?.dateLabel?.text = todos[indexPath.row].date
            cell?.tagLabel?.text = todos[indexPath.row].tag
        }
        if todos[indexPath.row].priority == 0 {
            cell?.priorityView.backgroundColor = .green
}      else if  todos[indexPath.row].priority == 1 {
            cell?.priorityView.backgroundColor = .yellow
}      else if todos[indexPath.row].priority == 2 {
            cell?.priorityView.backgroundColor = .red
}      else if todos[indexPath.row].priority == 3 {
            cell?.priorityView.backgroundColor = .systemBlue
    }
        return cell!
}
     
//    Handle  tableViewRowAction
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { action, indexPath in
           print(self.todos)
            try! self.realm.write({
                var todoTodelete = self.todos.remove(at: indexPath.row)
                self.realm.delete(todoTodelete)
            })
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
        let markAction = UITableViewRowAction(style: .default, title: "Mark as do") { action, indexPath in
            try! self.realm.write({
                self.todos[indexPath.row].priority = 3
                self.tableView.reloadData()
            })
        }
        markAction.backgroundColor = .lightGray
        return [deleteAction , markAction]
    }
    
    
//    prepare for searching
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            filteredTodo.removeAll()
            for todo in todos {
            if todo.text.lowercased().contains(searchText.lowercased()) {
            filteredTodo.append(todo)
                }
            }
        }else {
            searching = false
            filteredTodo.removeAll()
            filteredTodo = todos
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        filteredTodo.removeAll()
        tableView.reloadData()
    }

    

  
    
  

}
