//
//  StudentController.swift
//  Pair
//
//  Created by Aaron Prestidge on 4/10/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import Foundation
import CoreData

class StudentController {
    
    //MARK: - Properties
    static let shared =  StudentController()
    
    var fetchedResultsController: NSFetchedResultsController<Student>
    
    init() {
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let resultsController:  NSFetchedResultsController =  NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error), \(error.localizedDescription)\(#function)")
        }
     }
    
    //MARK: - CRUD
    func create(with name: String) {
        Student(name: name)
        saveToPersistentStore()
    }
    
    func update(student: Student, name: String) {
        student.name =  name
        saveToPersistentStore()
    }
    
    func delete(student: Student) {
        student.managedObjectContext?.delete(student)
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func saveToPersistentStore() {
        do {
                try CoreDataStack.context.save()
            } catch {
                print("There was an error performing the fetch: \(error.localizedDescription)\(#function)")
        }
    }
        
}//End Class

extension ListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
            case .delete:
                guard let indexPath = indexPath else { break }
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .insert:
                guard let newIndexPath = newIndexPath else { break }
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            case .move:
                guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
                tableView.moveRow(at: indexPath, to: newIndexPath)
            case .update:
                guard let indexPath = indexPath else { break }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            @unknown default:
                fatalError()
        }
    }
}
