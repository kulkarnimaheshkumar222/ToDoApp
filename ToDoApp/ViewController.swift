//
//  ViewController.swift
//  ToDoApp
//
//  Created by Student016 on 01/10/18.
//  Copyright © 2018 mahesh. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var taskTable: UITableView!
    let addtaskViewControllerObj = AddTaskViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskTable.dataSource = self
        taskTable.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addtaskViewControllerObj.getData()
        taskTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addtaskViewControllerObj.taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let task = addtaskViewControllerObj.taskArray[indexPath.row]
        if task.isImportant{
            cell.textLabel?.text = " 😰\(task.taskName!)"
        }
        else{
        cell.textLabel?.text = task.taskName!
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        if editingStyle == .delete
        {
           let task = addtaskViewControllerObj.taskArray[indexPath.row]
            context.delete(task)
            do{
            addtaskViewControllerObj.taskArray =  try context.fetch(request) as! [Task]
            }
            catch{
                print(error.localizedDescription)
            }
            
            do
            {
               try context.save()
            }
            catch{
                print(error.localizedDescription)
            }
            
            tableView.reloadData()
            
            
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

