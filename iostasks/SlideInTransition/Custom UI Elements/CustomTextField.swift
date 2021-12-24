//
//  CustomTextField.swift
//  SlideInTransition
//
//  Created by Drake on 3/28/19.
//

import UIKit

class CustomTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    func setup(){
    self.placeholder = "Take Dog Out"
    self.backgroundColor = .white
    self.borderStyle = .roundedRect
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
