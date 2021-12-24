import UIKit
import CoreData



class CustomCell: UITableViewCell {
 
    
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    //    @IBOutlet var iconsCell: UIImageView!
    

    
    func setTask(task: NSManagedObject ){
        taskLabel.text = task.value(forKey: "name") as? String
        dateLabel.text = task.value(forKey: "date") as?
        String

    }

    func labelsToWhite() {
        taskLabel.textColor = .white
        dateLabel.textColor = .white
    }

    func labelsToBlack() {
        taskLabel.textColor = .black
        dateLabel.textColor = .red
    }
    
    
    
    
//    func displayIcons(task:Task) {
//
//        let taskinfo = (task.isComplete , task.isImportant)
//        switch taskinfo {
//
//        case (false,false):
//            iconsCell.isHidden = true
//
//        case (true, false):
//            iconsCell.image = #imageLiteral(resourceName: "Star")
//            iconsCell.isHidden = false
//
//        case (false , true):
//            iconsCell.image = #imageLiteral(resourceName: "Priority")
//            iconsCell.isHidden = false
//
//        default:
//            iconsCell.isHidden = true
//        }
//
//
//    }

    
}



