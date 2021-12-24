
import UserNotifications
import CoreData
import UIKit
import ExpandingMenu

var todaysTasks: [NSManagedObject] = []
var tomorrowTasks: [NSManagedObject] = []
var allTasks: [NSManagedObject] = []

let ascendbyName = [NSSortDescriptor(key: "name", ascending: true)]
let ascendbyDate = [NSSortDescriptor(key: "nsdate", ascending: true)]
let ascendbyImportValue = [NSSortDescriptor(key: "importValue", ascending: false)]


var taskAdditionView:TaskAdditionView!

let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
// handler to access the core date database by using the context from the app delegate
let goalEntity = Goal(context: context)
let currentDate = Date()
let currentDateComponents = Calendar.current.dateComponents(in: .current, from: Date())


class HomeViewController: UIViewController {
    @IBOutlet weak var tomorrowDeadlinesTV: UITableView!
    var effect: UIVisualEffect!
    @IBOutlet var blurryView: UIVisualEffectView!
    @IBOutlet var addTaskFunction: UIBarButtonItem!
    @IBOutlet var homeTableView: UITableView!
    let selectedListView = CustomHorizontalPickerView()
    var allTaskViewController = AllTasksViewController()
    @IBAction func addTaskFunctions(_ sender: UIBarButtonItem) {
//
//    let calendarVC = addViewController(nibName: "addViewController", bundle: nil)
//    
        let addVC = addViewController(nibName: "addViewController", bundle: nil)
        self.present(addVC, animated: true)
        print("addVC presented")
    }
//
//    func presentAddView(sender: UIBarButtonItem){
//        let addVC = addViewController()
//        var backbutton = UIButton(type: .close)
//        backbutton.setImage(#imageLiteral(resourceName: "AddTask"), for: .normal)
//        backbutton.setTitle("Back", for: .normal)
//        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
//        backbutton.addTarget(self, action: "backAction", for: .touchUpInside)
//
//        addVC.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
//        self.present(addVC, animated: true)
//        }
//    func backAction() {
//        self.navigationController?.popViewController(animated: true)
    func setupExpandingMenuItem(){
    let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 150.0, height: 150.0)), image: #imageLiteral(resourceName: "add").withTintColor(.systemTeal), rotatedImage: #imageLiteral(resourceName: "add").withTintColor(.systemTeal))
        menuButton.center = CGPoint(x: self.view.bounds.width - 32.0, y: self.view.bounds.height - 72.0)
        view.addSubview(menuButton)
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Task", image: #imageLiteral(resourceName: "AddTask"), highlightedImage: #imageLiteral(resourceName: "AddTask"), backgroundImage: #imageLiteral(resourceName: "AddTask"), backgroundHighlightedImage: #imageLiteral(resourceName: "AddTask")){ () -> Void in
                        print("1")
            self.animateIn()
        }
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "Goal", image: #imageLiteral(resourceName: "AddTask"), highlightedImage: #imageLiteral(resourceName: "AddTask"), backgroundImage: #imageLiteral(resourceName: "AddTask"), backgroundHighlightedImage: #imageLiteral(resourceName: "AddTask")) { () -> Void in
            let goalVC = GoalViewController(nibName: "GoalViewController", bundle: nil)
            self.present(goalVC, animated: true)
            print("addVC presented")
            
        }
        
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Habbit", image: #imageLiteral(resourceName: "AddTask"), highlightedImage: #imageLiteral(resourceName: "AddTask"), backgroundImage: #imageLiteral(resourceName: "AddTask"), backgroundHighlightedImage: #imageLiteral(resourceName: "AddTask")){ () -> Void in
            print("1")
        }
                
        menuButton.addMenuItems([item1, item2, item3])
        menuButton.foldingAnimations = []
    }
    
    func animateIn(){
        taskAdditionView = TaskAdditionView()
        view.addSubview(taskAdditionView)
        view.bringSubviewToFront(taskAdditionView)
        taskAdditionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)//increase scale by 30%
        taskAdditionView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.blurryView.effect = self.effect
            taskAdditionView.alpha = 1
            taskAdditionView.transform = CGAffineTransform.identity // return to original scale
}
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.3) {
            taskAdditionView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            taskAdditionView.alpha = 0
            self.blurryView.effect = nil
        }
    }
    

    
    let transiton = SlideInTransition()
    var topView: UIView?
    func tableviewsConstraints(){

//        //Label
        let todaysdeadlineLabel = UILabel()
        self.view.addSubview(todaysdeadlineLabel)

        todaysdeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysdeadlineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        todaysdeadlineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        todaysdeadlineLabel.bottomAnchor.constraint(equalTo: homeTableView.topAnchor, constant: -5).isActive = true
        todaysdeadlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        todaysdeadlineLabel.text = "Today's Deadlines"
        todaysdeadlineLabel.textAlignment = .left
        todaysdeadlineLabel.font = UIFont(name: "Avenir-Black", size: 20)
        
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.layer.cornerRadius = 8
        homeTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        homeTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        homeTableView.topAnchor.constraint(equalToSystemSpacingBelow: self.view.topAnchor, multiplier: 15).isActive = true
        homeTableView.heightAnchor.constraint(equalToConstant: homeTableView.rowHeight * 3).isActive = true
        homeTableView.layer.borderWidth = 1.5
        homeTableView.layer.borderColor = UIColor
            .black.cgColor
        
        //         Tomorrow's Label
        let tomorrowdeadlineLabel = UILabel()
        self.view.addSubview(tomorrowdeadlineLabel)
        tomorrowdeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        tomorrowdeadlineLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        tomorrowdeadlineLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        tomorrowdeadlineLabel.bottomAnchor.constraint(equalTo: tomorrowDeadlinesTV.topAnchor, constant: -5).isActive = true
        tomorrowdeadlineLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tomorrowdeadlineLabel.text = "Tomorrow's Deadlines"
        tomorrowdeadlineLabel.textAlignment = .left
        tomorrowdeadlineLabel.font = UIFont(name: "Avenir-Black", size: 20)
        
        // Tomorrow's Deadlines TableView
        tomorrowDeadlinesTV.translatesAutoresizingMaskIntoConstraints = false
        tomorrowDeadlinesTV.layer.cornerRadius = 8
        tomorrowDeadlinesTV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        tomorrowDeadlinesTV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        tomorrowDeadlinesTV.topAnchor.constraint(equalTo: homeTableView.bottomAnchor, constant: 120).isActive = true
        tomorrowDeadlinesTV.heightAnchor.constraint(equalToConstant: tomorrowDeadlinesTV.rowHeight * 3).isActive = true
        tomorrowDeadlinesTV.layer.borderWidth = 1.5
        tomorrowDeadlinesTV.layer.borderColor = UIColor
            .black.cgColor
        

    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewLoaded")
        loadTasks(sort: .none)
        setupExpandingMenuItem()
        self.addChild(allTaskViewController)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        
        tableviewsConstraints()
         NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTableNotification"), object: nil)
                
        homeTableView.delegate = self
        homeTableView.dataSource = self
    
        effect = blurryView.effect
        blurryView.effect = nil
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (didallow, error) in
            if didallow == true {
                print("Notifications Allowed")
            } else {
                print(error)
                print("Notifications not allowed")
            }
        }
    
    }
    
    @objc func reloadTable(notification:Notification){
        animateOut()
        DispatchQueue.main.async {
//            self.loadTasks(sort: .none)
            self.homeTableView.reloadData()
            self.tomorrowDeadlinesTV.reloadData()
            self.allTaskViewController.tableView.reloadData()
            self.addTaskFunction.isEnabled = true
                      print("reloadTable() fired!")
        }
          }
    
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
 
    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title
//        self.homeTableView.reloadData()
//        self.tomorrowDeadlinesTV.reloadData()
        topView?.removeFromSuperview()
        
        switch menuType {
        case .Tasks:
            let view = allTaskViewController
            view.view.frame = self.view.bounds
            self.view.addSubview(view.view)
            self.topView = view.view
            self.allTaskViewController.tableView.reloadData()

        case .Stats:
            let view = UIView()
            view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        default:
            break
        }
    }

}


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}



extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == homeTableView{
        return todaysTasks.count
        } else if tableView == tomorrowDeadlinesTV {
            return tomorrowTasks.count
        } else {
            return 0
        }
    }
    
    
    // Cell Data and Configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == homeTableView {
        let task = todaysTasks[indexPath.row] // creating a new task from the already stored task depending on the indexpath.row if indexPath.row is 3 then the task is tasks[3]
       
//        let df = DateFormatter()
//        df.dateFormat = "dd-MM-yyyy" // assigning the date format
//        let now = df.string(from: currentDate)
////        if (task.value(forKey: "date") as! String == now){
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! CustomCell // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
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
        } else if tableView == tomorrowDeadlinesTV {
                    let task = tomorrowTasks[indexPath.row] // creating a new task from the already stored task depending on the indexpath.row if indexPath.row is 3 then the task is tasks[3]

                    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! CustomCell // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
                            cell.setTask(task: task) // this changes the label and date text since an instance of the task contains both the task and the date
                            if (task.value(forKey: "isComplete") as! Bool == true){
                            cell.labelsToWhite()
                            cell.backgroundColor = Colors.greencomplete
                            cell.selectionStyle = .none
                        
                        } else {
                            cell.backgroundColor = .white //adjust for nightmode later
                            cell.labelsToBlack()
                    }
                    

                    return cell
        }
        
        return UITableViewCell()

        
    }
            

    // Leading Swipe Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == homeTableView {
        let task = todaysTasks[indexPath.row]
        let complete = markCompleteToday(at: indexPath)
        if (task.value(forKey: "isComplete") as! Bool == false){
                return UISwipeActionsConfiguration(actions: [complete])
            
}
        } else if tableView == tomorrowDeadlinesTV{
            let task = tomorrowTasks[indexPath.row]
            let complete = markCompleteTomorrow(at: indexPath)
            if (task.value(forKey: "isComplete") as! Bool == false){
            
                   return UISwipeActionsConfiguration(actions: [complete])

            }
        }
        return         UISwipeActionsConfiguration(actions: [])

    }
    
    
    // Mark as Completed Task
    func markCompleteToday(at: IndexPath) -> UIContextualAction {
        
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy" // assigning the date format
        let now = df.string(from: Date()) // extracting the date with the given format
        let cell = homeTableView.cellForRow(at: at) as! CustomCell
        let task = todaysTasks[at.row]
        let completeActionImage = UIImage(named: "AddTask")?.withTintColor(.white)
        let action = UIContextualAction(style: .normal, title: "Complete") { (action, view, completion) in
            
            task.setValue(!(task.value(forKey: "isComplete") as! Bool), forKey: "isComplete")
            
            self.homeTableView.cellForRow(at: at)?.backgroundColor = task.value(forKey: "isComplete") as! Bool ? Colors.greencomplete : .white
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
    func markCompleteTomorrow(at: IndexPath) -> UIContextualAction {
         
         let df = DateFormatter()
         df.dateFormat = "dd-MM-yyyy" // assigning the date format
         let now = df.string(from: Date()) // extracting the date with the given format
         let cell = tomorrowDeadlinesTV.cellForRow(at: at) as! CustomCell
         let task = tomorrowTasks[at.row]
         let completeActionImage = UIImage(named: "AddTask")?.withTintColor(.white)
         let action = UIContextualAction(style: .normal, title: "Complete") { (action, view, completion) in
             
             task.setValue(!(task.value(forKey: "isComplete") as! Bool), forKey: "isComplete")
             
             self.tomorrowDeadlinesTV.cellForRow(at: at)?.backgroundColor = task.value(forKey: "isComplete") as! Bool ? Colors.greencomplete : .white
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
         
         action.image = completeActionImage
         action.backgroundColor = Colors.greencomplete
         return action
     }
    
    // Trailing Swipe Actions
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if tableView == homeTableView {
            let task = todaysTasks[indexPath.row]
            let important = changeTextAction(at: indexPath, table: self.homeTableView, arr: todaysTasks)
            let delete    = deleteActionToday(at: indexPath)
            
        if task.value(forKey: "isComplete") as? Bool == true {
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            return UISwipeActionsConfiguration(actions: [delete,important])
        }
        } else if tableView == tomorrowDeadlinesTV {
            let task = tomorrowTasks[indexPath.row]
                let important = changeTextAction(at: indexPath, table: self.tomorrowDeadlinesTV, arr: tomorrowTasks)
                let delete    = deleteActionTomorrow(at: indexPath)
            if task.value(forKey: "isComplete") as? Bool == true {
                return UISwipeActionsConfiguration(actions: [delete])
            } else {
                return UISwipeActionsConfiguration(actions: [delete,important])
            }
        } else {
        return UISwipeActionsConfiguration(actions: [])
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
    func changeTextAction(at: IndexPath , table:UITableView, arr:[NSManagedObject]) -> UIContextualAction{
        let editActionImage = UIImage(named: "Edit")?.withTintColor(.white)
        let action = UIContextualAction(style: .normal, title: "Important") { (action, view, completion) in
            self.changeTaskText(at: at, tableview: table, arr: arr)
            completion(true)
        }
        action.image = editActionImage
        action.backgroundColor = .purple
        return action
    }
    

    func deleteActionToday(at: IndexPath) -> UIContextualAction {
        let deleteActionImage = UIImage(named: "Delete")?.withTintColor(.white)
        let action = UIContextualAction(style: .destructive , title: "Delete") { (action, view, completion) in
            let objectToDelete = todaysTasks.remove(at: at.row)
            context.delete(objectToDelete)
            self.homeTableView.deleteRows(at: [at], with: .automatic)
            do {
            try
            context.save()
//                self.loadTasks(sort: .none)
                self.homeTableView.reloadData()
                self.tomorrowDeadlinesTV.reloadData()
                
            } catch {
            print("Problem while saving")
            }
            completion(true)
        }
        action.image = deleteActionImage
        action.backgroundColor = Colors.reddelete

        return action
    }
    func deleteActionTomorrow(at: IndexPath) -> UIContextualAction {
        let deleteActionImage = UIImage(named: "Delete")?.withTintColor(.white)
        let action = UIContextualAction(style: .destructive , title: "Delete") { (action, view, completion) in
            let objectToDelete = tomorrowTasks.remove(at: at.row)
            context.delete(objectToDelete)
            self.tomorrowDeadlinesTV.deleteRows(at: [at], with: .automatic)
            do {
            try
            context.save()
//                self.loadTasks(sort: .none)
                self.homeTableView.reloadData()
                self.tomorrowDeadlinesTV.reloadData()
            } catch {
            print("Problem while saving")
            }
            completion(true)
        }
        action.image = deleteActionImage
        action.backgroundColor = Colors.reddelete

        return action
    }


    

    func loadTasks(sort: [NSSortDescriptor]?){
        tomorrowTasks.removeAll()
        todaysTasks.removeAll()
        let tomorrow = DateComponents(year: currentDateComponents.year, month: currentDateComponents.month, day: currentDateComponents.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy" // assigning the date format
        let now = df.string(from: Date())
        let tomorrowDateString = df.string(from: dateTomorrow)
        print("TOMORROW'S DATE IS : " , tomorrowDateString)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        if let sort = sort{
        request.sortDescriptors = sort
        }
        do {
            allTasks = try context.fetch(request) as! [NSManagedObject]
            for item in allTasks {
            if item.value(forKey: "date") as! String == now {
                todaysTasks.append(item)
                }
            if item.value(forKey: "date") as! String == tomorrowDateString {
                tomorrowTasks.append(item)
                }
            }
          print("loadTasks() fired!")
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
//        self.homeTableView.reloadData()
//        self.tomorrowDeadlinesTV.reloadData()
//        self.allTaskViewController.tableView.reloadData()
        selectedListView.loadTasks()
    }
    
    func changeTaskText(at:IndexPath , tableview: UITableView , arr:[NSManagedObject]){
        
        let cell = tableview.cellForRow(at: at) as! CustomCell
        let task = arr[at.row]
        let alert = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (UIAlertAction) in
            task.setValue(alert.textFields![0].text!, forKey: "name")
            cell.setTask(task: task)
            do {
                try context.save()
                self.allTaskViewController.tableView.reloadData()
            } catch {
                print("Edit Fail")
            }
            print(task)
        }
        alert.addAction(submitAction)
        present(alert,animated: true)
    }
//    func deleteTask (at:IndexPath , tableview: UITableView , arr:[NSManagedObject]) {
//        var array = arr
//        let objectToDelete = array.remove(at: at.row)
//        context.delete(objectToDelete)
//        tableview.deleteRows(at: [at], with: .automatic)
//        do {
//        try
//        context.save()
//        self.loadTasks(sort: .none)
//        tableview.reloadData()
//        } catch {
//        print("Problem while saving")
//        }
//    }
//    func deleteAction(at: IndexPath, table:UITableView, arr:[NSManagedObject]) -> UIContextualAction {
//        let deleteActionImage = UIImage(named: "Delete")?.withTintColor(.white)
//
//        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
//                        self.deleteTask(at: at, tableview: table, arr: arr)
//
//        }
//        action.image = deleteActionImage
//        action.backgroundColor = Colors.reddelete
//        return action
//    }
//
        
}



