//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Student016 on 01/10/18.
//  Copyright © 2018 mahesh. All rights reserved.
//

import UIKit
import CoreData
class AddTaskViewController: UIViewController {
    var taskArray : [Task] = []
   let delegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var addTaskTextField: UITextField!
    
    
    @IBOutlet weak var isImportantSwitch: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
getData()
        // Do any additional setup after loading the view.
    }

    func getData() {
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do{
        taskArray = try context.fetch(request) as! [Task]
            //print(taskArray)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    
    @IBAction func addTaskAction(_ sender: UIButton) {
        
      let context = delegate.persistentContainer.viewContext
        
    let task = Task(context: context)
        task.taskName = addTaskTextField.text!
        task.isImportant = isImportantSwitch.isOn
        do{
            try context.save()
        }
        
        catch
        {
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
