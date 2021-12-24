//
//  File.swift
//  DaybyDay
//
//  Created by Drake on 2/27/19.
//  Copyright © 2019 Drake. All rights reserved.
//

import Foundation



class Task: NSObject , NSCoding {
    var taskDate:String
    var task:String
    var isImportant: Bool
    var isComplete: Bool
    
    
    
    init(task: String , taskDate: String , isImportant: Bool , isComplete: Bool){
        self.task = task
        self.taskDate = taskDate
        self.isImportant = isImportant
        self.isComplete = isComplete
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let taskDate = aDecoder.decodeObject(forKey: "taskDate") as? String ,
            let task = aDecoder.decodeObject(forKey: "task") as? String else {
                return nil
        }
        let importantDecode = aDecoder.decodeBool(forKey: "importantBool")
        let markCompleteDecode = aDecoder.decodeBool(forKey: "isComplete")
        self.init(task: task, taskDate: taskDate , isImportant: importantDecode , isComplete: markCompleteDecode)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskDate, forKey: "taskDate")
        aCoder.encode(task, forKey: "task")
        aCoder.encode(isImportant, forKey: "importantBool")
        aCoder.encode(isComplete, forKey: "isComplete")
    }
    
}
