//
//  AddTaskViewController.swift
//  ToDo List
//
//  Created by Juan Guardado on 12/31/18.
//  Copyright © 2018 Juan Guardado. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskInput: UITextField!
    @IBOutlet weak var ImportantToggle: UISwitch!

    var todoTableVC: TodoTableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AddTaskButton(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newTodoItem = ToDo(context: context)
            newTodoItem.important = ImportantToggle.isOn
            if let task = taskInput.text {
                newTodoItem.task = task
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
}
