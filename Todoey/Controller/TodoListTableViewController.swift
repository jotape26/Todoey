//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by João Leite on 09/04/18.
//  Copyright © 2018 João Leite. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    var ToDoList = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = ToDoList[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ToDoList[indexPath.row].done = !ToDoList[indexPath.row].done
        self.saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addToDoItem(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = ToDoItem()
            newItem.title = alertTextField.text!
            
            self.ToDoList.append(newItem)
            self.saveItems()
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new Item"
            alertTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.ToDoList)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding data, \(error)")
        }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                ToDoList = try decoder.decode([ToDoItem].self, from: data)
            } catch{
                
            }
            
        }

    }
    
}

