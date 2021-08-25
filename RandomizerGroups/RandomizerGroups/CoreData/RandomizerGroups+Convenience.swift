//
//  RandomizerGroups+Convenience.swift
//  RandomizerGroups
//
//  Created by Kyle Warren on 8/20/21.
//

import CoreData

extension Person {
    
    @discardableResult
    convenience init(name: String, isGrouped: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.isGrouped = isGrouped
    }
}
