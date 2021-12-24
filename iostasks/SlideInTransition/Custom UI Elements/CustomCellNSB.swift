import UIKit
import CoreData



class CustomCellNSB: UITableViewCell {
 
    var tLabel = UILabel()
    var dLabel = UILabel()

    
    func configureLabels() {
        //Task Name Label
        tLabel.numberOfLines = 0
        tLabel.contentMode = .left
        tLabel.adjustsFontSizeToFitWidth = false
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        tLabel.trailingAnchor.constraint(equalTo: dLabel.leadingAnchor, constant: -12).isActive = true
        tLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tLabel.widthAnchor.constraint(equalToConstant: 284).isActive = true
        
        
        //Task Date Label
//        dLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 15).isActive = true
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.numberOfLines = 0
        dLabel.contentMode = .left
        dLabel.adjustsFontSizeToFitWidth = false
        dLabel.translatesAutoresizingMaskIntoConstraints = false
        dLabel.leadingAnchor.constraint(equalTo: tLabel.trailingAnchor, constant: 8).isActive = true
        dLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        dLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 15).isActive = true
    }
    
    
    func setTask(task: NSManagedObject ){
        tLabel.text = task.value(forKey: "name") as? String
        dLabel.text = task.value(forKey: "date") as?
        String

    }

    func labelsToWhite() {
        tLabel.textColor = .white
        dLabel.textColor = .white
    }

    func labelsToBlack() {
        tLabel.textColor = .black
        dLabel.textColor = .red
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(tLabel)
        addSubview(dLabel)
        configureLabels()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



