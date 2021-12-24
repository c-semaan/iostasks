//
//  addViewController.swift
//  SlideInTransition
//
//  Created by Drake on 7/21/20.
//

import UIKit
import FSCalendar
import CoreData
class addViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func addTask(_ sender: Any) {
        let taskAdditionView = TaskAdditionView()
        self.view.addSubview(taskAdditionView)
        view.bringSubviewToFront(taskAdditionView)
        taskAdditionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)//increase scale by 30%
        taskAdditionView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            taskAdditionView.alpha = 1
            taskAdditionView.transform = CGAffineTransform.identity // return to original scale
        }
    }
    @IBOutlet weak var addButton: UIButton!
    var dateSelectedTasks: [NSManagedObject] = []
    var calendarDateSelected: String? = nil
    @IBOutlet weak var calendarTV: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    
    @IBAction func collapseCalendar(_ sender: Any) {
    calendar.scope = .week
        
        print("collapsed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarTV.register(UINib(nibName: "CustomCellNSB2", bundle: nil), forCellReuseIdentifier: "CustomCellNSB2")
        calendarTV.dataSource = self
        calendarTV.delegate = self
        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = false
        let currentDate = Date()
        reloadCalendar(date: currentDate)
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        reloadCalendar(date: date)
    
    }
    

    
    func reloadCalendar(date : Date){
                let df = DateFormatter()
                df.dateFormat = "dd-MM-yyyy" // assigning the date format
                let now = df.string(from: date) // extracting the date with the given format
                calendarDateSelected = now
                print(calendarDateSelected!)

        dateSelectedTasks = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")

        do {
            allTasks = try context.fetch(request) as! [NSManagedObject]
            for item in allTasks {
            if item.value(forKey: "date") as! String == now {
                dateSelectedTasks.append(item)
                }
            }
          print("loadTasks() fired!")
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        calendarTV.reloadData()
        dateLabel.text = calendarDateSelected
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateSelectedTasks.count
    
    }
    
    
    // Cell Data and Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = dateSelectedTasks[indexPath.row] // creating a new task from the already stored task depending on the indexpath.row if indexPath.row is 3 then the task is tasks[3]
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
    
}
