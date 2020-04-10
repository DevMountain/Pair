//
//  PersonDetailViewController.swift
//  PairGenrator
//
//  Created by Hin Wong on 4/10/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    //MARK: - Properties
    var person: Person?
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let person = person {
            nameTextField.text = person.name
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let newName = nameTextField.text, !newName.isEmpty,
        let person = person
        else { return }
        
        PersonController.shared.updatePerson(person: person, name: newName)
        navigationController?.popViewController(animated: true)
    }
    
}
