//
//  ListTableViewController.swift
//  Pair
//
//  Created by Aaron Prestidge on 4/10/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentController.shared.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func createPairsButtonTapped(_ sender: UIBarButtonItem) {
        var pairs = StudentController.shared.fetchedResultsController.fetchedObjects
        pairs?.shuffle()
        tableView.reloadData()
    }
    
    @IBAction func addButtontapped(_ sender: UIBarButtonItem) {
        presentAddStudentAlert()
    }
    
    // MARK: - Alert
    func presentAddStudentAlert() {
        let addAlertController = UIAlertController(title: "Add Student", message: "Add a student to your list.", preferredStyle: .alert)
        var newStudentTextField: UITextField?
        addAlertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Student name..."
            newStudentTextField = alertTextField
        }
        let cancelAction =  UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let inputText = newStudentTextField?.text else {return}
            StudentController.shared.create(with: inputText)
            self.tableView.reloadData()
        }
        addAlertController.addAction(cancelAction)
        addAlertController.addAction(addAction)
        present(addAlertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    func indexOfCell(indexPath: IndexPath) -> Int {
        return (indexPath.section * 2) + indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if (StudentController.shared.fetchedResultsController.fetchedObjects?.count ?? 0) % 2 == 0 {
            return (StudentController.shared.fetchedResultsController.fetchedObjects?.count ?? 0) / 2
        } else {
            return ((StudentController.shared.fetchedResultsController.fetchedObjects?.count ?? 0) / 2) + 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (StudentController.shared.fetchedResultsController.fetchedObjects?.count ?? 0) % 2 == 0 {
            return 2
        }  else {
            if section == (tableView.numberOfSections - 1) {
                return 1
            } else {
                return 2
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        let student = StudentController.shared.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = student.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let student = StudentController.shared.fetchedResultsController.object(at: indexPath)
            StudentController.shared.delete(student: student)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStudentDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? StudentDetailViewController else {return}
            let student =  StudentController.shared.fetchedResultsController.object(at: indexPath)
            destination.student = student
        }
    }

}//End Class

extension Array {
    mutating func shuffle() {
        for _ in 0..<10  {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}//End Extension

@IBDesignable extension UIButton {
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
