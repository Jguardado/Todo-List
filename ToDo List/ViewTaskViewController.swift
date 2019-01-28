//
//  ViewTaskViewController.swift
//  ToDo List
//
//  Created by Juan Guardado on 12/31/18.
//  Copyright © 2018 Juan Guardado. All rights reserved.
//

import UIKit

class ViewTaskViewController: UIViewController {
    
    var currentTask: ToDo? = nil
    var todoTableVC: TodoTableViewController? = nil
    
    @IBOutlet weak var taskLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentTask = currentTask {
            if currentTask.important {
                if let name = currentTask.task {
                    taskLabel?.text = "❗️" + name
                }
            } else {
                taskLabel?.text = currentTask.task
            }
        }
    }
    
    @IBAction func completedButton(_ sender: Any) {
        // Delete todo and pop back
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let currentTask = currentTask {
                context.delete(currentTask)
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
}
