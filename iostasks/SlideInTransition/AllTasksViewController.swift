//
//  AllTasksViewController.swift
//  SlideInTransition
//
//  Created by Drake on 4/26/19.
//

import UIKit
import CoreData
import UserNotifications

let homeVC = HomeViewController()
var pinnedTasks: [NSManagedObject] = []
let tasksEntityObject = Tasks(context: context)
var listPicker = CustomHorizontalPickerView()
class AllTasksViewController: UIViewController{
    
    var tableView = UITableView()
    // Number of Rows
    func configureTableView(){
        
        view.addSubview(tableView)
       
        //Setting up the HeaderView
        var headerView = UIView()
        self.view.addSubview(headerView)
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive=true
        
        //Setting up the list pikcer
       
        headerView.addSubview(listPicker)
        
        listPicker.translatesAutoresizingMaskIntoConstraints = false

        listPicker.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        listPicker.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        listPicker.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5).isActive = true
        listPicker.heightAnchor.constraint(equalToConstant:50).isActive = true


          var importanceSegmentControl = CustomSegmentControl()
            importanceSegmentControl.addTarget(self, action: #selector(indexChanged(control:)),for: UIControl.Event.valueChanged)
        importanceSegmentControl.items = ["Date", "Importance","A-Z"]
        headerView.addSubview(importanceSegmentControl)
//
        importanceSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        importanceSegmentControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        importanceSegmentControl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5).isActive = true
        importanceSegmentControl.topAnchor.constraint(equalTo: listPicker.bottomAnchor).isActive = true
        importanceSegmentControl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5).isActive = true
       
        setTableViewDelegates()
        tableView.rowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        self.tableView.topAnchor.constraint(equalToSystemSpacingBelow: headerView.bottomAnchor, multiplier: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.register(UINib(nibName: "CustomCellNSB2", bundle: nil), forCellReuseIdentifier: "CustomCellNSB2")
    }
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupSegmentControl(){


    }
    
    @objc func indexChanged(control : CustomSegmentControl) {
        // This all works fine and it prints out the value of 3 on any click

        switch control.selectedIndex {
        case 0:
            
            homeVC.loadTasks(sort: ascendbyDate)
            listPicker.loadTasks()
            NotificationCenter.default.post(name: NSNotification.Name("reloadAllTasksTableNotification") , object: nil)
        case 1:
            homeVC.loadTasks(sort: ascendbyImportValue)
            listPicker.loadTasks()

                    NotificationCenter.default.post(name: NSNotification.Name("reloadAllTasksTableNotification") , object: nil)
        
        case 2:

            homeVC.loadTasks(sort: ascendbyName)
            listPicker.loadTasks()

                    NotificationCenter.default.post(name: NSNotification.Name("reloadAllTasksTableNotification") , object: nil)

        default:
            break;
        }  //Switch
    } // indexChanged for the Segmented Control

        //implement tableview methods here

        override func viewDidLoad(){
            super.viewDidLoad()
            listPicker.loadTasks()
            NotificationCenter.default.addObserver(self, selector: #selector(reloadTable2), name: NSNotification.Name(rawValue: "reloadAllTasksTableNotification"), object: nil)
            self.tableView.tableHeaderView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            configureTableView()
            print("allTasksView loaded")
                        //add some positioning and size constraints here for allTasksView
        }
    @objc func reloadTable2(notification:Notification){
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
      }
    }

extension AllTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedlistTasks.count
    }
    
    
    // Cell Data and Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = selectedlistTasks[indexPath.row] // creating a new task from the already stored task depending on the indexpath.row if indexPath.row is 3 then the task is tasks[3]
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellNSB2", for: indexPath) as! CustomCellNSB2 // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
                        
        
        cell.setTask(task: task) // this changes the label and date text since an instance of the task contains both the task and the date
        
         if (task.value(forKey: "isComplete") as! Bool == true){
                        cell.labelsToWhite()
                        cell.backgroundColor = Colors.greencomplete
                        cell.selectionStyle = .none
                    
                    } else {
                        cell.backgroundColor = .white //adjust for nightmode later
                        cell.labelsToBlack()
                }
                

                
                
                print("CellData Task :", task.value(forKey: "isComplete") as! Bool, task.value(forKey: "name") as! String)
                
        
                return cell
        
    }
    
     // Leading Swipe Action
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let task = selectedlistTasks[indexPath.row]
            let complete = markComplete(at: indexPath)
            if !(task.value(forKey: "isComplete") as! Bool){
                return UISwipeActionsConfiguration(actions: [complete])
            } else {
                return UISwipeActionsConfiguration(actions: [])
            }
            
        }
        
        
        // Mark as Completed Task
        func markComplete(at: IndexPath) -> UIContextualAction {
            
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy" // assigning the date format
            let now = df.string(from: Date()) // extracting the date with the given format
            let cell = tableView.cellForRow(at: at) as! CustomCellNSB2
            let task = selectedlistTasks[at.row]
            let completeActionImage = UIImage(named: "AddTask")?.withTintColor(.white)
            let action = UIContextualAction(style: .normal, title: "Complete") { (action, view, completion) in
                
                task.setValue(!(task.value(forKey: "isComplete") as! Bool), forKey: "isComplete")
                
                self.tableView.cellForRow(at: at)?.backgroundColor = task.value(forKey: "isComplete") as! Bool ? Colors.greencomplete : .white
                cell.backgroundColor = Colors.greencomplete
                cell.labelsToWhite()
                
                task.setValue("Finished " + now, forKey: "date")
                do {
                    try
                    context.save()
                } catch {
                    print("Markcomplete save error")
                }
                
                //            cell.displayIcons(task: task)
                completion(true)
                
            }
            
            //action.image = #imageLiteral(resourceName: "AddTask")
            action.image = completeActionImage
            action.backgroundColor = Colors.greencomplete
            return action
        }
        
        // Trailing Swipe Actions
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let task = selectedlistTasks[indexPath.row]
            let important = importantAction(at: indexPath)
            let delete    = deleteAction(at: indexPath)
            
            if task.value(forKey: "isComplete") as? Bool == true {
                return UISwipeActionsConfiguration(actions: [delete])
            } else {
                return UISwipeActionsConfiguration(actions: [delete,important])
            }
        }
        
        
        // Mark as Important Action
        // notification toggle
        func toggleTaskReminder(at: IndexPath) -> UIContextualAction{
           // let reminderImage = UIImage(named: "")
            let action = UIContextualAction(style: .normal, title: "Notification") { (action, view, completion) in
                
            }
            return action
        }
        func importantAction(at: IndexPath) -> UIContextualAction{
            let editActionImage = UIImage(named: "Edit")?.withTintColor(.white)
            let action = UIContextualAction(style: .normal, title: "Important") { (action, view, completion) in

                self.changeTextAlert(at: at)

                
                completion(true)
            }
            action.image = editActionImage
            action.backgroundColor = .purple
            return action
        }
        
        // Delete Action
        func deleteAction(at: IndexPath) -> UIContextualAction {
            let deleteActionImage = UIImage(named: "Delete")?.withTintColor(.white)
            let action = UIContextualAction(style: .destructive , title: "Delete") { (action, view, completion) in
                let objectToDelete = selectedlistTasks.remove(at: at.row)
                context.delete(objectToDelete)
                self.tableView.deleteRows(at: [at], with: .automatic)
                do {
                try
                context.save()
                homeVC.loadTasks(sort: ascendbyName)
                
                self.tableView.reloadData()
                  
                NotificationCenter.default.post(name: NSNotification.Name("reloadTableNotification") , object: nil)
                } catch {
                print("Problem while saving")
                }
                completion(true)
            }
            action.image = deleteActionImage
            action.backgroundColor = Colors.reddelete
            return action
        }
        

        
        func changeTextAlert(at:IndexPath){
            
            let cell = tableView.cellForRow(at: at) as! CustomCellNSB2
            let task = selectedlistTasks[at.row]
            let alert = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
            alert.addTextField()
            let submitAction = UIAlertAction(title: "Submit", style: .default) { (UIAlertAction) in
                task.setValue(alert.textFields![0].text!, forKey: "name")
                cell.setTask(task: task)
                do {
                    try context.save()

                } catch {
                    print("Edit Fail")
                    
                }
                print(task)
            }
            alert.addAction(submitAction)
            present(alert,animated: true)
        }
}
