//
//  ReminderView.swift
//  SlideInTransition
//
//  Created by Drake on 8/23/20.
//

import UIKit
import PopupDialog
class ReminderView: UIView {
    
    var datePicker: UIDatePicker = UIDatePicker()
    var horizontalStackView: UIStackView = UIStackView()
    var button8: UIButton = UIButton()
    var button12: UIButton = UIButton()
    var button15: UIButton = UIButton()
    var button20: UIButton = UIButton()
    var cancel: UIButton = CancelButton(title: "Cancel", action: .none)
    var save: UIButton = UIButton()
    var popupDialog: PopupDialog =  PopupDialog(title: "Set Reminder", message: .none)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    } // initiliaze the view like this TaskAdditionView()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    func setupDialog() {
        
       }
    
    func setupConstraints(){
        
        // View Contstaints
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -20).isActive = true
        heightAnchor.constraint(equalToConstant: 420).isActive = true
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        backgroundColor = .blue
        layer.cornerRadius = 15
        
        
        self.addSubview(datePicker)
        self.bringSubviewToFront(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        datePicker.minuteInterval = 5
        
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

func removeAllConstraintsFromView(view: UIView) { for c in view.constraints { view.removeConstraint(c) } }

}

