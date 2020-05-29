//
//  StudentDetailViewController.swift
//  Randomizer
//
//  Created by Aaron Prestidge on 5/28/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {

    //MARK: - Properties
    var student: Student? {
        didSet {
            self.loadViewIfNeeded()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let student = student {
            nameTextField.text = student.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let name = self.nameTextField.text,
            let student = self.student else { return }
        StudentController.shared.update(with: student, and: name)
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}//End Class
