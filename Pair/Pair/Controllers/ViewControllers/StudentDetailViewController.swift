//
//  StudentDetailViewController.swift
//  Pair
//
//  Created by Aaron Prestidge on 4/10/20.
//  Copyright © 2020 AaronPrestidge. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {

    //MARK: - Properties
    var student: Student?
    
    //MARK: - Outlets
    @IBOutlet weak var updateStudentTextField: UITextField!
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let nameText = self.updateStudentTextField.text,
            let student =  self.student else {return}
        StudentController.shared.update(student: student, name: nameText)
    }
    
    @IBAction func cencelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
