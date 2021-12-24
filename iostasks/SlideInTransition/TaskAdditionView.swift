
import UserNotifications
import UIKit
import CoreData

class TaskAdditionView: UIView {
    
    var importanceSegmentControl: CustomSegmentControl!
    var taskTextField: CustomTextField!
    var submitButton:CustomButton!
    var reminderSwitch: UISwitch!
    var datePicker: UIDatePicker!
    var dateSelected: Date? = Date()
    var importanceValue: Int16 = 0
    var listPicker: CustomHorizontalPickerView!
    var listname: String!
//    let rotationAngle:CGFloat = 90 * (.pi / 180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    } // initiliaze the view like this TaskAdditionView()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    func setupSwitchPicker(){
        reminderSwitch = UISwitch()
        reminderSwitch.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(pickingDate(sender:)), for: .valueChanged)
    }
    func setupListPickerView(){
        listPicker = CustomHorizontalPickerView()
    }
    

    
    @objc func pickingDate(sender: UIDatePicker){
        self.dateSelected = sender.date
        print("Date selected: \(dateSelected)")
    }
    


    @objc func indexChanged(control : CustomSegmentControl) {
        // This all works fine and it prints out the value of 3 on any click

        switch control.selectedIndex {
        case 0:
        importanceValue = 0
            print(importanceValue)
        case 1:
        importanceValue = 1
            print(importanceValue)

        case 2:
        importanceValue = 2
        print(importanceValue)

        default:
            break;
        }  //Switch
    } // indexChanged for the Segmented Control

    
    func setupSegmentControl(){
        importanceSegmentControl = CustomSegmentControl()
        importanceSegmentControl.addTarget(self, action: #selector(indexChanged(control:)),for: UIControl.Event.valueChanged)
        }
    
    func setupButton(){
        let myAttributes = [ NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 18.0)! , NSAttributedString.Key.foregroundColor: UIColor.white ]
        

        let myTitle = "Add"
        let myAttributedTitle = NSAttributedString(string: myTitle, attributes: myAttributes)
        submitButton = CustomButton()
        submitButton.setAttributedTitle(myAttributedTitle, for: .normal)
        submitButton.addTarget(self, action: #selector(submitFunction(sender:)), for: .touchUpInside)
    }
    
    
    // Submit Function
    @objc func submitFunction(sender: CustomButton){
        print("Worked")
        submitButton.shake()
        NotificationCenter.default.post(name: NSNotification.Name("reloadTableNotification") , object: nil)
        
        addTask()
        
        if (reminderSwitch.isOn){
        setupNotification()
        print(dateSelected)
        }
        NSLayoutConstraint.deactivate(self.constraints)
        removeFromSuperview()
        
    }
    
    func setupTextField(){
          taskTextField = CustomTextField()
    }
    
    func setupConstraints(){
        setupListPickerView()
        setupTextField()
        setupSegmentControl()
        setupButton()
        setupSwitchPicker()
        addSubview(listPicker)
        addSubview(importanceSegmentControl!)
        addSubview(taskTextField)
        addSubview(submitButton)
        reminderSwitch.transform = reminderSwitch.transform.rotated(by: -(.pi/2))
        addSubview(reminderSwitch)
        addSubview(datePicker)
        
        // View Contstaints
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 40).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -40).isActive = true
        heightAnchor.constraint(equalToConstant: 420).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        backgroundColor = .white
        layer.cornerRadius = 15
        
    
        
        
        // UIVIEWPICKER Constraints
        listPicker.translatesAutoresizingMaskIntoConstraints = false
        listPicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        listPicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        listPicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        listPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        let originalFrame = listPicker.frame
//
//        listPicker.transform = CGAffineTransform(rotationAngle: -90 * (.pi/180) )
//        listPicker.frame = originalFrame
       
       
       // Switch Constraints
        reminderSwitch.translatesAutoresizingMaskIntoConstraints = false
        reminderSwitch.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        reminderSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true

        
        //DatePicker Constraints
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        datePicker.topAnchor.constraint(equalTo: listPicker.bottomAnchor, constant: 20).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: taskTextField.topAnchor, constant: -10).isActive = true
        datePicker.minuteInterval = 5
        
        // TextField Constraints
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        taskTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        taskTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        taskTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        taskTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // ImportanceControl Constraints
        importanceSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        importanceSegmentControl.topAnchor.constraint(equalTo: self.taskTextField.bottomAnchor, constant: 30).isActive = true
        importanceSegmentControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        importanceSegmentControl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        importanceSegmentControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        // Submit Button Constraint
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    override func didMoveToSuperview() {
        setupConstraints()
    }
    
    override func removeFromSuperview() {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        NSLayoutConstraint.deactivate(self.constraints)
        
        removeAllConstraintsFromView(view: self)
    }

    func addTask(){
       
       
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy" // assigning the date format
        
        
            let now = reminderSwitch.isOn ? df.string(from: dateSelected!) : df.string(from: Date()) // extracting the date with the given format
        let selectedList = listNames[listPicker.selectedRow(inComponent:0)]
        print("the selected list is", selectedList)
        print("Reminder Switch is ON: ", reminderSwitch.isOn)
        // Adding a task to the array
        let entity =
                NSEntityDescription.entity(forEntityName: "Tasks",
                                   in: context)!
         let newTask = NSManagedObject(entity: entity, insertInto: context)
         newTask.setValue(taskTextField.text!, forKey: "name")
         newTask.setValue(false, forKey: "isComplete")
         newTask.setValue(now, forKey: "date")
         newTask.setValue(Date(), forKey: "nsdate")
         newTask.setValue(importanceValue, forKey: "importValue")
         newTask.setValue(selectedList, forKey: "list")
        do {
            try
            context.save()
            homeVC.loadTasks(sort: .none)
            print("addTask() fired!")
            } catch {
            print("Problem while saving")
            }

        self.removeFromSuperview()
        }
    
    
    func setupNotification(){
        let now : Date? = Date()
        guard let currentDate = now, let interval = dateSelected?.timeIntervalSince(currentDate), interval > 0 else {
            print("Interval <= 0")
            return
        }
       
        
        let notifcation = UNMutableNotificationContent()
        notifcation.title = "Task Reminder"
        notifcation.subtitle = taskTextField.text ?? "Empty"
        notifcation.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "taskReminder", content: notifcation, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        taskTextField.endEditing(true)
    }

}
func removeAllConstraintsFromView(view: UIView) { for c in view.constraints { view.removeConstraint(c) } }

extension UIView {
    func removeAllConstraints() {
        let superViewConstraints = superview?.constraints.filter{ $0.firstItem === self || $0.secondItem === self } ?? []
        
        superview?.removeConstraints(superViewConstraints + constraints)
    }
}


