//
//  RandomizerController.swift
//  RandomizerGroups
//
//  Created by Kyle Warren on 8/20/21.
//

import CoreData

class RandomizerController {
    
    static let shared = RandomizerController()
    
    var people: [Person] = []
    
    //MARK: - CRUD
    
    func createPersonWith(name: String){
        let newPerson = Person(name: name)
        people.append(newPerson)
        
        CoreDataStack.saveContext()
    }
    
    func update(person: Person, name: String) {
        person.name = name
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsGrouped(person: Person) {
        person.isGrouped.toggle()
        
        CoreDataStack.saveContext()
    }
    
    func deletePerson(person: Person) {
        guard let index = people.firstIndex(of: person) else { return }
        people.remove(at: index)
        
        CoreDataStack.context.delete(person)
        CoreDataStack.saveContext()
    }
} // End of Class
