//
//  StudentController.swift
//  StudentPairs
//
//  Created by Aaron Prestidge on 5/29/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import CoreData
import Foundation

class StudentController {
    
    //MARK: - Shared Instance
    static let shared = StudentController()
    
    //MARK: - Properties
    var students: [Student] {
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        let result = try? CoreDataStack.context.fetch(request)
        print("Students array set")
        return result ?? []
    }
    
    var pairs: [[Student]] = []
    
    //MARK: - Helper Methods
    func shuffle() {
        var tempStudents: [Student] = []
        var tempPairs: [[Student]] = []
        for student in students.shuffled() {
            if tempStudents.count < 2 {
                tempStudents.append(student)
                print("Student added to temporary array of students")
            } else if tempStudents.count == 2 {
                tempPairs.append(tempStudents)
                print("Student pair added to temporary array of pairs")
                tempStudents = []
                print("Temp student array emptied")
                tempStudents.append(student)
                print("Student added to temp students array")
            }
        }
        if tempStudents.count  > 0 {
            tempPairs.append(tempStudents)
            print("Student pair added to temporary array of pairs")
        }
        pairs = tempPairs
        print("Pairs property set equal to tempPairs array.")
    }

    //MARK: - CoreData Persistence
    private func saveToPersistentStore() {
        let mOC = CoreDataStack.context
        do {
            try mOC.save()
            print("Data saved to CoreData")
        } catch {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    //MARK: - CRUD Functions
    func create(from name: String) {
        let _ = Student(name: name)
        print("New student created")
        saveToPersistentStore()
    }
    
    func update(with student: Student, and name: String) {
        student.name = name
        print("Student has been updated")
        saveToPersistentStore()
    }
    
    func delete(student: Student) {
        CoreDataStack.context.delete(student)
        print("Student has been deleted")
        saveToPersistentStore()
    }
    
    
}//End Class
