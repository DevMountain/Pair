//
//  PairsTableViewController.swift
//  PairGenrator
//
//  Created by Hin Wong on 4/10/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class PairsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var pairs: [[Person]]?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generatePairs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func pairUpButtonTapped(_ sender: Any) {
        generatePairs()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Person Please", message: "Add a person to the list.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Full Name"
            textField.autocapitalizationType = .words
            textField.autocorrectionType = .no
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else {
                self.present(alertController, animated: true)
                return
            }
            
            PersonController.shared.createPerson(name: name)
            self.generatePairs()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true)
    }
    
    //MARK: - Helper functions
    
    func generatePairs() {
        pairs = PersonController.shared.pairingUp()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return pairs?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pairs?[section].count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pairCell", for: indexPath)

        let person = pairs?[indexPath.section][indexPath.row]
        cell.textLabel?.text = person?.name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let person = pairs?[indexPath.section][indexPath.row] else {return}
            
            pairs?[indexPath.section].remove(at: indexPath.row)
            PersonController.shared.deletePerson(person: person)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPersonDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? PersonDetailViewController
            else {
                print("Cannot segue to details view")
                return}
            
            destination.person = pairs?[indexPath.section][indexPath.row]
        }
    }
    

}
