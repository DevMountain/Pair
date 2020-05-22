//
//  NameConvenienceInit.swift
//  Pair
//
//  Created by Ian Richins on 5/22/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation
import CoreData

extension Name {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
    self.init(context: context)
        self.name = name
       
    }
}
