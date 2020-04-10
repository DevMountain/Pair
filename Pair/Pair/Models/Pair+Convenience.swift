//
//  Pair+Convenience.swift
//  Pair
//
//  Created by Aaron Prestidge on 4/10/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import Foundation
import CoreData

extension Student {
    @discardableResult
    convenience init(name: String, moc: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
    }
}
