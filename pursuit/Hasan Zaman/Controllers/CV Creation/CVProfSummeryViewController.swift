//
//  CVProfSummeryViewController.swift
//  pursuit
//
//  Created by BP-36-201-09 on 19/12/2024.
//

import UIKit

class CVProfSummeryViewController: UIViewController {
    @IBOutlet weak var summaryTextView: UITextView!
    
    // Properties from previous screen
    var firstName: String = ""
    var lastName: String = ""
    var cpr: String = ""
    var age: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "CvCreationJobseeker", bundle: nil)
        if let workExpVC = storyboard.instantiateViewController(withIdentifier: "CVCreationWorkEXPPageTableViewController") as? CVCreationWorkEXPPageTableViewController {
            workExpVC.firstName = firstName
            workExpVC.lastName = lastName
            workExpVC.cpr = cpr
            workExpVC.age = age
            workExpVC.phoneNumber = phoneNumber
            workExpVC.email = email
            workExpVC.professionalSummary = summaryTextView.text ?? ""
            
            navigationController?.pushViewController(workExpVC, animated: true)
        }
    }
}
