//
//  Person+Convenience.swift
//  PairGenrator
//
//  Created by Hin Wong on 4/10/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    @discardableResult
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
