//
//  CVCReationInputTableViewController.swift
//  pursuit
//
//  Created by BP-36-201-25 on 11/12/2024.
//

import UIKit

class CVCReationInputTableViewController: UITableViewController {
    // Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var cprTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "CvCreationJobseeker", bundle: nil)
        if let profSumVC = storyboard.instantiateViewController(withIdentifier: "CVProfSummeryViewController") as? CVProfSummeryViewController {
            profSumVC.firstName = firstNameTextField.text ?? ""
            profSumVC.lastName = lastNameTextField.text ?? ""
            profSumVC.cpr = cprTextField.text ?? ""
            profSumVC.age = ageTextField.text ?? ""
            profSumVC.phoneNumber = phoneNumberTextField.text ?? ""
            profSumVC.email = emailTextField.text ?? ""
            
            navigationController?.pushViewController(profSumVC, animated: true)
        }
    }
}
