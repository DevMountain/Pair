//
//  StudentsTableViewController.swift
//  StudentPairs
//
//  Created by Aaron Prestidge on 5/29/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import UIKit

class StudentsTableViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        StudentController.shared.shuffle()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAddStudentAlert()
        tableView.reloadData()
        print("Add student alert controller presented, table view reloaded")
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIBarButtonItem) {
        StudentController.shared.shuffle()
        tableView.reloadData()
        print("Student pairs shuffled, table view reloaded")
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
            StudentController.shared.create(from: inputText)
            StudentController.shared.shuffle()
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return StudentController.shared.pairs.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pair \(section + 1)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentController.shared.pairs[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        let pair = StudentController.shared.pairs[indexPath.section]
        let student = pair[indexPath.row]
        cell.textLabel?.text = student.name
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let student = StudentController.shared.pairs[indexPath.section][indexPath.row]
            StudentController.shared.pairs[indexPath.section].remove(at: indexPath.row)
            StudentController.shared.delete(student: student)
            tableView.deleteRows(at: [indexPath], with: .fade)
            StudentController.shared.shuffle()
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? StudentDetailViewController else { return }
            destination.student = StudentController.shared.pairs[indexPath.section][indexPath.row]
        }
    }
    
}//End Class

@IBDesignable extension UIButton {
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        } get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue }
        get {
            return layer.cornerRadius }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        } get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}//End Extension
