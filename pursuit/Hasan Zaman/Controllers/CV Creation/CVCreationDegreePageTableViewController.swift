//
//  CVCreationDegreePageTableViewController.swift
//  pursuit
//
//  
//

import UIKit

class CVCreationDegreePageTableViewController: UITableViewController {
    
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var institutionTextField: UITextField!
    @IBOutlet weak var graduationYearTextField: UITextField!
    @IBOutlet weak var additionalNotesTextView: UITextView!
    
    var firstName: String = ""
    var lastName: String = ""
    var cpr: String = ""
    var age: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var professionalSummary: String = ""
    var jobTitle: String = ""
    var company: String = ""
    var workStartYear: String = ""
    var workEndYear: String = ""
    var responsibilities: String = ""
    
  
    
    @IBAction func submitButtonTapped(_ sender: UIBarButtonItem) {
        // 1. Create WorkExperience struct
        let workExperience = CVModel.WorkExperience(
            jobTitle: jobTitle,
            company: company,
            startYear: workStartYear,
            endYear: workEndYear,
            responsibilities: responsibilities
        )
        
        // 2. Create Education struct
        let education = CVModel.Education(
            degree: degreeTextField.text ?? "",
            institution: institutionTextField.text ?? "",
            graduationYear: graduationYearTextField.text ?? "",
            additionalNotes: additionalNotesTextView.text ?? ""
        )
        
        // 3. Create complete CV model
        let cvData = CVModel(
            firstName: firstName,
            lastName: lastName,
            cpr: cpr,
            age: age,
            phoneNumber: phoneNumber,
            email: email,
            professionalSummary: professionalSummary,
            workExperience: workExperience,
            education: education
        )
        
        // 4. Save the CV data
        CVDataManager.shared.saveCV(cvData)
        
        // 5. Navigate back to root view controller
        navigationController?.popToRootViewController(animated: true)
    }
}


//GraduationYear: graduationYearTextField.text?? "",
//AdditionalNotes: additionalNotesTextView.text?? "",
