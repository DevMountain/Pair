//
//  PairController.swift
//  Pairs
//
//  Created by Theo Vora on 4/25/20.
//  Copyright © 2020 Joy Bending. All rights reserved.
//

import Foundation

class PairController {
    
    // MARK: - Singleton
    static let shared = PairController()
    
    
    // MARK: - Source of Truth
    var persons: [Person] = []
    
    
    // MARK: - Properties
    var pairings: [[Person]] {
        get {
            var pairings = [[Person]]()
            var section: Int = 0
            var row: Int = 0
            
            for name in persons {
                if row == 0 {
                    // create new section. then append.
                    var sectionArray = [Person]()
                    sectionArray.append(name)
                    pairings.append(sectionArray)
                    
                    row = 1
                }
                else {
                    // section already exists. just append
                    var sectionArray = pairings[section]
                    sectionArray.append(name)
                    pairings[section] = sectionArray
                                
                    // increment section
                    section += 1
                    row = 0
                }
            }
            
            return pairings
        }
    }
    
    var sections: Int {
        return pairings.count
    }
    
    // MARK: - Initializer
    
    init() {
        loadFromPersistence()
    }
    
    // MARK: - Helper Functions
    
    func insertMockData() {
        let a = Person(name: "Al Green")
        let b = Person(name: "Billy Bob")
        
        add(person: a)
        add(person: b)
    }
    
    
    // MARK: - CRUD
    
    func add(person: Person) {
        persons.append(person)
        
        saveToPersistentStorage(persons: persons)
    }
    
    func delete(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        let index = (section * 2) + row
        
        persons.remove(at: index)
        
        saveToPersistentStorage(persons: persons)
    }
    
    func randomize() {
        persons.shuffle()
        
        saveToPersistentStorage(persons: persons)
    }
    
    
    // MARK: - Persistence
    
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "pairs.json"
        let documentDirectory = urls[0]
        let documentsDirectoryURL = documentDirectory.appendingPathComponent(fileName)
        return documentsDirectoryURL
    }

    func saveToPersistentStorage(persons: [Person]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(persons)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to persistent storage: \(error)")
        }
    }

    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedData = try jsonDecoder.decode([Person].self, from: data)
            self.persons = decodedData
        } catch let error {
            print("\(error.localizedDescription) -> \(error)")
        }
    }

}
