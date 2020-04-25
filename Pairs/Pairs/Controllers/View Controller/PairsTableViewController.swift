//
//  PairsTableViewController.swift
//  Pairs
//
//  Created by Theo Vora on 4/25/20.
//  Copyright © 2020 Joy Bending. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PairController.shared.persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let person = PairController.shared.persons[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PairController.shared.delete(index: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.delegate = self
            textField.placeholder = "Full Name"
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
        }
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                       !name.isEmpty else { return }
            
            // add this name into our source of truth
            
            let person = Person(name: name)
            PairController.shared.add(person: person)
            
            // reload the table view
            self.tableView.reloadData()
        }
        alert.addAction(saveButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    

    

    
    
    

}
