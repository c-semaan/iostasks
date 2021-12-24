////
////  AllTasksView.swift
////  SlideInTransition
////
////  Created by Drake on 4/26/19.
////
//
//import UIKit
//
//class AllTasksView: UIView {
//    let homevc = HomeViewController()
//    var tableview:UITableView!
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//    }
//    override func didMoveToSuperview() {
//        
//    createTableView()
//    }
//    
//    func createTableView(){
//        tableview = UITableView()
//        self.addSubview(tableview)
//        tableview.translatesAutoresizingMaskIntoConstraints = false
//        tableview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        tableview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        tableview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        tableview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//}
//
//}
