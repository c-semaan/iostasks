//
//  CustomHorizontalPickerView.swift
//  SlideInTransition
//
//  Created by Drake on 7/12/20.
//

import UIKit
import CoreData

var rotationAngle:CGFloat!
var listNames = ["Home","Work"]
var selectedlist = listNames[0]
var selectedlistTasks : [NSManagedObject] = []
let allTasksVC = AllTasksViewController()
var rowHeight = 50
class CustomHorizontalPickerView: UIPickerView {
    
    func loadTasks(){
        selectedlistTasks = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")

                do {
                        let allTasks = try context.fetch(request) as! [NSManagedObject]
                           for item in allTasks {
                           if item.value(forKey: "list") as! String == selectedlist {
                               selectedlistTasks.append(item)
                               }
                        }

                      print("loadTasks() fired!")
                    } catch let error as NSError {
                      print("Could not fetch. \(error), \(error.userInfo)")
                    }
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        delegate = self
        dataSource = self
        
    }
    override init(frame: CGRect) {
        super.init(frame : frame)
        delegate = self
        dataSource = self
    }
}
extension CustomHorizontalPickerView: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listNames.count
    }
    }
extension CustomHorizontalPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(rowHeight)
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: rowHeight))
        let listLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: rowHeight))
        listLabel.textAlignment = .center
        listLabel.font = UIFont(name: "Avenir-Black", size: 16)
        
        view.addSubview(listLabel)
        listLabel.text = listNames[row]
//        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))

        return view
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedlist = listNames[row]
        
        print(selectedlist)
        print("INDEX selectedLISTTASKS", selectedlistTasks.count)
        loadTasks()
        NotificationCenter.default.post(name: NSNotification.Name("reloadAllTasksTableNotification") , object: nil)
        
    }
    
}
