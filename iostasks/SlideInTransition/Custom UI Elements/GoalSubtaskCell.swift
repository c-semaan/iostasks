//
//  GoalSubtaskCell.swift
//  SlideInTransition
//
//  Created by Drake on 8/20/20.
//

import UIKit

protocol SubTaskCellDelegate {
    func didTapDelete(cell: UITableViewCell)
}

class GoalSubtaskCell: UITableViewCell, UITextViewDelegate {
    var delegate : SubTaskCellDelegate?
    @IBOutlet weak var leftButton: UIButton!
    var rightButtonClicked: Bool! = false
    @IBAction func enteredTextField(_ sender: Any) {
        
        rightButton.alpha = 1
        rightButton.isUserInteractionEnabled = true
        
        
        leftButton.setImage(#imageLiteral(resourceName: "checkmark"), for: .normal)
        leftButton.isUserInteractionEnabled = true
        
    }
    @IBAction func markComplete(_ sender: Any) {
        leftButton.tintColor = Colors.greencomplete
    }
    @IBOutlet weak var rightButton: UIButton!
    var textChanged: ((String) -> Void)?

    @IBOutlet weak var subtaskTextView: UITextField!
   
    @IBAction func rightAction(_ sender: Any) {
        if (rightButtonClicked == false){
        numberOfRowsGoals = numberOfRowsGoals + 1
        NotificationCenter.default.post(name:
            NSNotification.Name("reloadGoalTableNotification") , object: nil)
        print("Number of rows", numberOfRowsGoals)
        rightButtonClicked = true
        rightButton.setImage(#imageLiteral(resourceName: "Delete"), for: .normal)
        rightButton.tintColor = .systemRed
        }else {
            delegate?.didTapDelete(cell: self)
        }
//

    }
    

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textChanged(action: @escaping (String) -> Void) {
           self.textChanged = action
       }
       
       func textViewDidChange(_ textView: UITextView) {
           textChanged?(textView.text)
       }
    
}
