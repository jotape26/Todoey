//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by João Leite on 09/04/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var ToDoList = ["Play Fortnite"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let array = defaults.array(forKey: "ToDoListArray") as? [String] {
            ToDoList = array
        }
    }
    
    //TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = ToDoList[indexPath.row]
        return cell
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            self.ToDoList.append(alertTextField.text!)
            self.defaults.set(self.ToDoList, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Item"
            alertTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

