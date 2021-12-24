////
////  TasksTableView.swift
////  SlideInTransition
////
////  Created by Drake on 3/23/19.
////
//
//import UIKit
//var tasks = [Task]()
//class TasksTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
//// Number of Rows
////    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tasks.count
//    }
//    
//    
//    // Cell Data and Configuration
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let task = tasks[indexPath.row] // creating a new task from the already stored task depending on the indexpath.row if indexPath.row is 3 then the task is tasks[3]
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! CustomCell // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
//        
//        //        cell.setTask(task: task) // this changes the label and date text since an instance of the task contains both the task and the date
//        
//        //        if (task.isImportant) {
//        //            cell.labelsToWhite()
//        //        }else {
//        //            cell.labelsToGray()
//        //        }
//        
//        //        if (task.isComplete){
//        //            cell.labelsToGray()
//        //            cell.backgroundColor = .green
//        //            cell.selectionStyle = .none
//        //        }
//        
//        if !(task.isComplete){
//            cell.backgroundColor = task.isImportant ? .purple : .white //according to the task isImportant attribute we set the background color
//        }
//        return cell
//        
//    }
//    
//    // Leading Swipe Action
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let task = tasks[indexPath.row]
//        let complete = markComplete(at: indexPath)
//        if !(task.isComplete){
//            return UISwipeActionsConfiguration(actions: [complete])
//        } else {
//            return UISwipeActionsConfiguration(actions: [])
//        }
//        
//    }
//    
//    
//    // Mark as Completed Task
//    func markComplete(at: IndexPath) -> UIContextualAction {
//        let cell = self.cellForRow(at: at) as! CustomCell
//        let task = tasks[at.row]
//        let action = UIContextualAction(style: .normal, title: "Complete") { (action, view, completion) in
//            
//            task.isComplete = !task.isComplete
//            task.isImportant = false
//            self.cellForRow(at: at)?.backgroundColor = task.isComplete ? .green : .white
//            cell.backgroundColor = .green
//            //            cell.labelsToGray()
//            //        //Implement Save Function
//            //            cell.displayIcons(task: task)
//            completion(true)
//            
//        }
//        action.image = #imageLiteral(resourceName: "Check")
//        action.backgroundColor = .green
//        return action
//    }
//    
//    // Trailing Swipe Actions
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let task = tasks[indexPath.row]
//        let important = importantAction(at: indexPath)
//        let delete    = deleteAction(at: indexPath)
//        
//        if task.isComplete {
//            return UISwipeActionsConfiguration(actions: [delete])
//        } else {
//            return UISwipeActionsConfiguration(actions: [delete,important])
//        }
//    }
//    
//    
//    // Mark as Important Action
//    func importantAction(at: IndexPath) -> UIContextualAction{
//        let cell = self.cellForRow(at: at) as! CustomCell
//        let task = tasks[at.row]
//        let action = UIContextualAction(style: .normal, title: "Important") { (action, view, completion) in
//            task.isComplete  = false
//            task.isImportant = !task.isImportant
//            
//            //            self.tableView.cellForRow(at: at)?.backgroundColor = task.isImportant ? .purple : .white
//            
//            //            if (task.isImportant){
//            //                cell.labelsToWhite()
//            //            } else {
//            //                cell.labelsToGray()
//            //            }
//            //
//            //            // implement save function
//            //            cell.displayIcons(task: task)
//            
//            
//            
//            
//            
//            completion(true)
//        }
//        action.image = #imageLiteral(resourceName: "Alarm")
//        action.backgroundColor = .purple
//        return action
//    }
//    
//    // Delete Action
//    func deleteAction(at: IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive , title: "Delete") { (action, view, completion) in
//            tasks.remove(at: at.row)
//            self.deleteRows(at: [at], with: .automatic)
//            
//            // implement Save Tasks
//            //            if (tasksAccomplished != 0) {
//            //                tasksAccomplished = tasksAccomplished - 1
//            //            }
//            completion(true)
//        }
//        action.image = #imageLiteral(resourceName: "Trash")
//        action.backgroundColor = .red
//        return action
//    }
//    
//}
//    
//    
//
