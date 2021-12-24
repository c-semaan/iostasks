
import UIKit
import UserNotifications
class CustomView: UIView {
    var datepicker:UIDatePicker!
    var submitButton:CustomButton!
    var datepicked: Date?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    } // initiliaze the button like this CustomButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupDatePicker() {
        datepicker = UIDatePicker()
        datepicker.minimumDate = Date()
        datepicker.addTarget(self, action: #selector(datePicker(sender:)), for: .valueChanged)
        datepicker.setValue(Colors.starYellow, forKey: "textColor")
    }
    
    func setupButton(){
        submitButton = CustomButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(dateSubmission(sender:)), for: .touchUpInside)
        bringSubviewToFront(submitButton)
    }
    
    func addingSubviews() {
        setupDatePicker()
        setupButton()
        addSubview(datepicker)
        addSubview(submitButton)
    }
    
    
    
    func setupConstraints(){
        
        addingSubviews()
        //Custom View Constraints
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -20).isActive = true
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        backgroundColor = Colors.darkBackground
        layer.cornerRadius = 15
        
        //DatePicker Constraints
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        datepicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        datepicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        datepicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        datepicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        // Button Constraints
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.leadingAnchor.constraint(equalTo: datepicker.leadingAnchor, constant: 100).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: datepicker.trailingAnchor, constant: -100).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: datepicker.bottomAnchor, constant: 35).isActive = true
        
        
        
    }
    
    
    override func didMoveToSuperview() {
        setupConstraints()
        
    }
    
    
    @objc func datePicker(sender: UIDatePicker){
        self.datepicked = sender.date
        print("Date selected: \(datepicked)")
    }
    
    @objc func dateSubmission(sender: CustomButton){
        sender.shake()
        let currentDate = Date()
        let interval = datepicked?.timeIntervalSince(currentDate)
        
        let notifcation = UNMutableNotificationContent()
        notifcation.title = "test"
        notifcation.subtitle = "test"
        notifcation.body = "test2"
        notifcation.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval!, repeats: false)
        let request = UNNotificationRequest(identifier: "taskReminder", content: notifcation, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}

