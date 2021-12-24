//
//  ReminderViewController.swift
//  SlideInTransition
//
//  Created by Drake on 8/24/20.
//

import UIKit
import FSCalendar
import UserNotifications
class ReminderViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    var reminderDate : String?
    var reminderDay : Int?
    var reminderMonth : Int?
    var reminderYear : Int?
    var reminderHour : Int?
    var reminderMinute : Int?

    @IBOutlet weak var todayButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBAction func clearAction(_ sender: Any) {
    todayAction(sender)
    nowAction(sender)
    }
    @IBAction func todayAction(_ sender: Any) {
        let date = Date()
        reminderCalendar.select(date, scrollToDate: true)
    }
    @IBOutlet weak var reminderCalendar: FSCalendar!
    
    @IBOutlet weak var rDatePicker: UIDatePicker!
    @IBAction func reminderDatePicker(_ sender: Any) {
            var df = DateFormatter()
            let date = rDatePicker.date
            let dateAsString = df.string(from: date)
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            reminderHour = components.hour!
            reminderMinute = components.minute!
            print(reminderHour)
    }


    @IBOutlet weak var eightButton: UIButton!
    @IBAction func eightAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"

        let date = dateFormatter.date(from: "8:00")
        rDatePicker.date = date!
    }
    @IBOutlet weak var fifteenButton: UIButton!
    @IBAction func fifteenAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"

        let date = dateFormatter.date(from: "15:00")
        rDatePicker.date = date!
    }
    @IBOutlet weak var twentyButton: UIButton!
    
    @IBAction func twentyAction(_ sender: Any) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat =  "HH:mm"

    let date = dateFormatter.date(from: "20:00")
    rDatePicker.date = date!
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneAction(_ sender: Any) {
        var calendar = Calendar.current
//        calendar.timeZone = TimeZone.current
        let totalComponents = NSDateComponents()
        totalComponents.day = reminderDay!
        totalComponents.hour = reminderHour!
        totalComponents.month = reminderMonth!
        totalComponents.minute = reminderMinute!
        totalComponents.year = reminderYear!
        totalComponents.timeZone = TimeZone(abbreviation: "UTC")
        let finalDate = calendar.date(from: totalComponents as DateComponents)
          print(finalDate)
        
        //notifcation
            let now : Date? = Date()
          guard let currentDate = now, let interval = finalDate?.timeIntervalSince(currentDate), interval > 0 else {
              print("Interval <= 0")
              return
          }
         print("Interval", interval)
          
          let notifcation = UNMutableNotificationContent()
          notifcation.title = "Task Reminder"
          notifcation.subtitle = "TEST"
          notifcation.badge = 1

          let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
          let request = UNNotificationRequest(identifier: "taskReminder", content: notifcation, trigger: trigger)
          UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        self.dismiss(animated: true)

    }
    
    @IBOutlet weak var nowButton: UIButton!
    @IBAction func nowAction(_ sender: Any) {
    let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let dateS = dateFormatter.string(from: date)
        let dateF = dateFormatter.date(from: dateS)

        
        rDatePicker.date = dateF!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rDatePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        self.view.widthAnchor.constraint(equalToConstant: 500).isActive = true
        reminderCalendar.delegate = self
        reminderCalendar.dataSource = self
        
    let totalComponents = NSDateComponents()
    let calendar = Calendar.current
    let date = Date()
    var components = Calendar.current.dateComponents([.hour, .minute, .month, .day , .year , .timeZone], from: date)
    reminderHour = components.hour!
    reminderMinute = components.minute!
    reminderMonth = components.month!
    reminderDay = components.day!
    reminderYear = components.year!
    components.timeZone = TimeZone(abbreviation: "UTC")
    let finalDate = calendar.date(from: components as DateComponents)
    print("FINAL" , finalDate)
    
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            print(date)
            var df = DateFormatter()
            df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            reminderDate =  df.string(from: date)
            reminderMonth = Calendar.current.component(.month, from: date)
            reminderDay = Calendar.current.component(.day, from: date)
            reminderYear = Calendar.current.component(.year, from: date)
        
        print(reminderMonth)
        print(reminderYear)
        print(reminderDay)
    }
}
