//
//  GoalViewController.swift
//  SlideInTransition
//
//  Created by Drake on 8/20/20.
//
import FSCalendar
import PopupDialog
import UIKit
var numberOfRowsGoals : Int = 1
class GoalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsGoals
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if ((indexPath as NSIndexPath).row == (numberOfRowsGoals - 1)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoalSubtaskCell", for: indexPath) as! GoalSubtaskCell // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
            cell.delegate = self
            cell.textChanged {[weak tableView] (newText: String) in
                              tableView?.beginUpdates()
                              tableView?.endUpdates()
                   }
                   return cell
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "GoalSubtaskCell", for: indexPath) as! GoalSubtaskCell // setting the identifier ( we have already set in the storyboard, the class of our cells to be our custom cell)
            cell.delegate = self
            cell.textChanged {[weak tableView] (newText: String) in
                       tableView?.beginUpdates()
                       tableView?.endUpdates()
            }
            return cell
        }
    }
    @IBOutlet weak var goalTitle: UITextField!
    
    @IBAction func goalTitleTF(_ sender: Any) {
    }
    @IBOutlet weak var goalVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadGoalTableNotification"), object: nil)
        
        goalVC.translatesAutoresizingMaskIntoConstraints = false

        goalVC.register(UINib(nibName: "GoalSubtaskCell", bundle: nil), forCellReuseIdentifier: "GoalSubtaskCell")
        goalVC.delegate = self
        goalVC.dataSource = self
        numberOfRowsGoals = 1
        //        goalVC.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        goalVC.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60).isActive = true
    
    }
    func deleteRow (cell: GoalSubtaskCell){
        
    }

        @objc func reloadTable(notification:Notification){
            DispatchQueue.main.async {
                self.goalVC.beginUpdates()
                self.goalVC.insertRows(at: [IndexPath.init(row: numberOfRowsGoals - 1, section: 0)], with: .automatic)
                self.goalVC.endUpdates()            }
              }
        
        

    @IBAction func setReminder(_ sender: Any) {
    let reminderView = ReminderViewController()

    // Create the dialog
    let popup = PopupDialog(viewController: reminderView, preferredWidth: 500)
        //    popup.buttonAlignment = .horizontal
//    let cancelButton = CancelButton(title: "CANCEL") {
//        print("You canceled the car dialog.")
//    }
//
//    // This button will not the dismiss the dialog
//    let AddButton = DefaultButton(title: "BUY CAR", height: 60) {
//        print("Ah, maybe next time :)")
//    }
//
//    popup.addButtons([cancelButton, AddButton])
    popup.transitionStyle = .bounceUp
        // Present dialog
        
        self.present(popup, animated: true, completion: nil)
    
    
    
    
    }
    
  

}
extension GoalViewController : SubTaskCellDelegate {
    func didTapDelete(cell: UITableViewCell) {
        if (numberOfRowsGoals > 1){
        numberOfRowsGoals = numberOfRowsGoals - 1
        goalVC.deleteRows(at: [IndexPath(row: goalVC.indexPath(for: cell)!.row , section: 0)] , with: .left)
    }
    }
    }
