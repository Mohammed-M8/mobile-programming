//
//  CVCReationInputTableViewController.swift
//  pursuit
//
//  Created by BP-36-201-25 on 11/12/2024.
//

import UIKit

class CVCReationInputTableViewController: UITableViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var cprTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
        if validateInputs() {
                // The segue will happen automatically since it's connected in storyboard
                // No need to manually perform the segue
            } else {
                // Prevent the automatic segue if validation fails
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                // Re-enable the button after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
        }
    }
    // Add validation method
    private func validateInputs() -> Bool {
        // First Name validation
        if firstNameTextField.text?.isEmpty ?? true {
            showAlert(message: "First Name should not be empty!")
            return false
        }
        
        // Last Name validation
        if lastNameTextField.text?.isEmpty ?? true {
            showAlert(message: "Last Name should not be empty!")
            return false
        }
        
        // CPR validation
        if cprTextField.text?.isEmpty ?? true {
            showAlert(message: "CPR should not be empty!")
            return false
        }
        
        // Age validation
        if ageTextField.text?.isEmpty ?? true {
            showAlert(message: "Age should not be empty!")
            return false
        }
        
        if let age = Int(ageTextField.text ?? "0"), age < 18 {
            showAlert(message: "Must be 18 or above")
            return false
        }
        
        // Phone Number validation
        if phoneTextField.text?.isEmpty ?? true {
            showAlert(message: "Phone Number should not be empty!")
            return false
        }
        
        // Email validation
        if emailTextField.text?.isEmpty ?? true {
            showAlert(message: "Email should not be empty!")
            return false
        }
        
        return true
    }
    
    // Helper method to show alerts
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // Override prepare for segue to validate before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if !validateInputs() {
            // This will prevent the segue from occurring
            let _ = navigationController?.popViewController(animated: true)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates for text fields
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        cprTextField.delegate = self
        ageTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
    }
}


extension CVCReationInputTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Validate individual fields as they finish editing
        if textField == ageTextField {
            if let age = Int(textField.text ?? "0"), age < 18 {
                showAlert(message: "Must be 18 or above")
                textField.text = ""
            }
        }
    }
}
