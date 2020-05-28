//
//  StudentController.swift
//  Randomizer
//
//  Created by Aaron Prestidge on 5/28/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import CoreData
import Foundation

class StudentController {
    
    //MARK: - Shared Instance
    static let shared = StudentController()
    var students: [Student] = [Student]()
    
    //MARK: - Initializer
    init() {
        students = loadFromPersistentStore()
    }
    
    //MARK: - Persistence Functions
    private func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("Error saving to persistent store \(error), \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [Student] {
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            guard let students = try? CoreDataStack.context.fetch(request) else { return [Student]() }
            return students
        } catch {
            print("Error fetching records from persistent store \(error), \(error.localizedDescription)")
            return []
        }
    }
    
    //MARK: - CRUD Functions
    func create(name: String) {
        Student(name: name)
        saveToPersistentStore()
        students = loadFromPersistentStore()
    }
    
    func update(student: Student, name: String) {
        student.name = name
        saveToPersistentStore()
        students = loadFromPersistentStore()
    }
    
    func delete(student: Student) {
        CoreDataStack.context.delete(student)
        saveToPersistentStore()
        students = loadFromPersistentStore()
    }
    
    
}//End Class
