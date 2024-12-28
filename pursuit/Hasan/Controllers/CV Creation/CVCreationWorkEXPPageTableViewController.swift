//
//  CVCreationWorkEXPPageTableViewController.swift
//  pursuit
//
//
//

import UIKit

class CVCreationWorkEXPPageTableViewController: UITableViewController {
    // Outlets
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var startYearTextField: UITextField!
    @IBOutlet weak var endYearTextField: UITextField!
    @IBOutlet weak var responsibilitiesTextView: UITextView!
    
    // Properties from previous screens
    var firstName: String = ""
    var lastName: String = ""
    var cpr: String = ""
    var age: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var professionalSummary: String = ""
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "CvCreationJobseeker", bundle: nil)
        if let degreeVC = storyboard.instantiateViewController(withIdentifier: "CVCreationDegreePageTableViewController") as? CVCreationDegreePageTableViewController {
            // Pass personal info
            degreeVC.firstName = firstName
            degreeVC.lastName = lastName
            degreeVC.cpr = cpr
            degreeVC.age = age
            degreeVC.phoneNumber = phoneNumber
            degreeVC.email = email
            degreeVC.professionalSummary = professionalSummary
            
            // Pass work experience
            degreeVC.jobTitle = jobTitleTextField.text ?? ""
            degreeVC.company = companyTextField.text ?? ""
            degreeVC.workStartYear = startYearTextField.text ?? ""
            degreeVC.workEndYear = endYearTextField.text ?? ""
            degreeVC.responsibilities = responsibilitiesTextView.text ?? ""
            
            navigationController?.pushViewController(degreeVC, animated: true)
        }
    }
}
