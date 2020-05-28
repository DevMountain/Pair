//
//  StudentTableViewController.swift
//  Randomizer
//
//  Created by Aaron Prestidge on 5/28/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
 
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAddStudentAlert()
        tableView.reloadData()
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIBarButtonItem) {
        StudentController.shared.students.shuffle()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    func indexOfCell(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + indexPath.row
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if StudentController.shared.students.count % 2 == 0 {
            return StudentController.shared.students.count / 2
        } else {
            return (StudentController.shared.students.count / 2) + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if StudentController.shared.students.count % 2 == 0 {
            return 2
        } else {
            if section == (tableView.numberOfSections - 1) {
                return 1
            } else {
                return 2
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        let student = StudentController.shared.students[indexOfCell(indexPath: indexPath)]
        cell.textLabel?.text = student.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let student = StudentController.shared.students[indexOfCell(indexPath: indexPath)]
            StudentController.shared.delete(student: student)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }    
    }
    
    // MARK: - Methods
    func presentAddStudentAlert() {
        let alertController = UIAlertController(title: "Add Student", message: "Add a new student to the list", preferredStyle: .alert)
        var newStudentTextField: UITextField?
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter name..."
            newStudentTextField = alertTextField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let inputText = newStudentTextField?.text else { return }
            StudentController.shared.create(name: inputText)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let student = StudentController.shared.students[indexPath.row]
            let updateVC = segue.destination as? StudentDetailViewController
            updateVC?.student = student
        }
    }

    
}//End Class

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}
