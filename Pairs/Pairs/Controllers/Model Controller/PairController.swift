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
    
    init() {
        insertMockData()
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
    }
    
    func delete(index: Int) {
        persons.remove(at: index)
    }
}
