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
    var student: Student?
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) {
            guard let name = self.nameTextField.text,
                let student = self.student else { return }
            StudentController.shared.update(student: student, name: name)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}//End Class
