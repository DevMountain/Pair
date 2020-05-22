//
//  Name.swift
//  Pair
//
//  Created by Ian Richins on 5/22/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let contaier: NSPersistentContainer = {
        
        // remember to change name of container!!
        let container = NSPersistentContainer(name: "Pair")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return contaier.viewContext }
}
