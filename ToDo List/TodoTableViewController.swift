//
//  TodoTableViewController.swift
//  ToDo List
//
//  Created by Juan Guardado on 12/30/18.
//  Copyright © 2018 Juan Guardado. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {
    var toDos = [ToDo]()
    
    override func viewWillAppear(_ animated: Bool) {
        getTodos()
    }
    
    func getTodos () {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let todosFromCoreData = try? context.fetch(ToDo.fetchRequest()) {
                if let tempToDos = todosFromCoreData as? [ToDo] {
                    toDos = tempToDos
                    tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let currentTodo = toDos[indexPath.row]
        
        if currentTodo.important {
            if let name = currentTodo.task {
                cell.textLabel?.text = "❗️" + name
            }
        } else {
            cell.textLabel?.text = currentTodo.task
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = toDos[indexPath.row]
        performSegue(withIdentifier: "moveToSelectedTask", sender: selectedTask)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let taskVC = segue.destination as?
            ViewTaskViewController {
            if let selectedTask = sender as? ToDo {
                taskVC.currentTask = selectedTask
            }
            
            taskVC.todoTableVC = self
            
        }
        
        if let addTaskVC = segue.destination as? AddTaskViewController {
            addTaskVC.todoTableVC = self
        }
    }

}
