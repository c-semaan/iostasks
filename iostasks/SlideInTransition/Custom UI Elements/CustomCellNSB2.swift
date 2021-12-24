//
//  CustomCellNSB2.swift
//  SlideInTransition
//
//  Created by Drake on 7/8/20.
//

import UIKit
import CoreData
class CustomCellNSB2: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var importanceImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTask(task: NSManagedObject ){
        taskLabel.text = task.value(forKey: "name") as? String
        dateLabel.text = task.value(forKey: "date") as?
        String
        
        if (task.value(forKey: "importValue") as? Int16 == 2){
            importanceImageView.alpha = 1
        } else {
            importanceImageView.alpha = 0
        }

    }

    func labelsToWhite() {
        taskLabel.textColor = .white
        dateLabel.textColor = .white
    }

    func labelsToBlack() {
        taskLabel.textColor = .black
        dateLabel.textColor = .red
    }
    
}
