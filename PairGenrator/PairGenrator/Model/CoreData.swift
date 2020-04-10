//
//  CoreData.swift
//  PairGenrator
//
//  Created by Hin Wong on 4/10/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    //MARK: - Core data stack
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlaylistCoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistet stores \(error)")
            }
        }
        return container
    } ()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    //MARK: - Core data saving
    
    static func saveContext () {
          let context = CoreDataStack.context
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  let nserror = error as NSError
                  fatalError("Unresolved error saving Core Data context:\n\(nserror), \(nserror.userInfo)")
              }
          }
      }
}

