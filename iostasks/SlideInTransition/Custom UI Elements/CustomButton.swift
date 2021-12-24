//
//  CustomButton.swift
//  DaybyDay
//
//  Created by Drake on 3/2/19.
//  Copyright © 2019 Drake. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    } // initiliaze the button like this CustomButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    } //initiliaze the button via storyboard
    func setupButton() {
        setShadow()
        setTitleColor(.white ,for: [.normal,.selected,.highlighted])
        
        backgroundColor       = .black
//        titleLabel?.font      = UIFont(name: "AvenirNext", size: 15)
        layer.cornerRadius    = 15
//        layer.borderWidth     = 1.0
//        layer.borderColor     = UIColor.darkGray.cgColor
    }
    
    
    private func setShadow() {
        layer.shadowColor   = UIColor.black.cgColor
//        layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
//        layer.shadowRadius  = 5
//        layer.shadowOpacity = 0.1
        clipsToBounds       = true
        layer.masksToBounds = false
    }
    
    
    func shake() {
        let shake           = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint       = CGPoint(x: center.x - 8, y: center.y)
        let fromValue       = NSValue(cgPoint: fromPoint)
        
        let toPoint         = CGPoint(x: center.x + 8, y: center.y)
        let toValue         = NSValue(cgPoint: toPoint)
        
        shake.fromValue     = fromValue
        shake.toValue       = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    
    
    
    
}
