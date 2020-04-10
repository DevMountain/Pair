//
//  PersonController.swift
//  PairGenrator
//
//  Created by Hin Wong on 4/10/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    //MARK: - Properties
    static let shared = PersonController()
    
    var persons: [Person] {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    //MARK: - CRUD Functions
    
    func createPerson(name: String) {
        Person(name: name)
        CoreDataStack.saveContext()
    }
    
    func updatePerson(person: Person, name: String) {
        person.name = name
        CoreDataStack.saveContext()
    }
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
    }
    
    //MARK: - Helper Functions
    
    //TODO: - Potential error
    
    func pairingUp() -> [[Person]]{
        let randomPairs = persons.shuffled()
        
        var pairs = [[Person]]()
        var pair = [Person]()
        
        for person in randomPairs {
            if pair.count == 0 {
                pair.append(person)
            } else {
                pair.append(person)
                pairs.append(pair)
                pair = [Person]()
            }
            
        }
        return pairs
    }
    
}//End of class
