//
//  Student+Convenience.swift
//  Randomizer
//
//  Created by Aaron Prestidge on 5/28/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import CoreData
import Foundation

extension Student {
    
    @discardableResult
    convenience init(name: String, moc: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
    }
    
}//End Ext
