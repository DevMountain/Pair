//
//  RandomizerDetailViewController.swift
//  RandomizerGroups
//
//  Created by Kyle Warren on 8/20/21.
//

import UIKit

class RandomizerDetailViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var nameTextField: UITextField!
    
    
    //MARK: - PROPERTIES
    var people: Person?
    
    //MARK: - LIFECYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - ACTIONS
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        
        if let people = people {
            RandomizerController.shared.update(person: people, name: name)
        } else {
            RandomizerController.shared.createPersonWith(name: name)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let people = people else { return }
        nameTextField.text = people.name
    }


}
