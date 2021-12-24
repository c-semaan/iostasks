//
//  Tasks+CoreDataProperties.swift
//  SlideInTransition
//
//  Created by Drake on 7/18/20.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var date: String?
    @NSManaged public var importValue: Int16
    @NSManaged public var isComplete: Bool
    @NSManaged public var list: String?
    @NSManaged public var name: String?
    @NSManaged public var goals: NSSet?

}

// MARK: Generated accessors for goals
extension Tasks {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}
