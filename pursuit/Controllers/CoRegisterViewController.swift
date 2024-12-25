//
//  CoRegisterViewController.swift
//  pursuit
//
//  Created by BP-36-201-01 User on 25/12/2024.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class CoRegisterViewController: UIViewController {

    // Outlets for your UITextFields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!

    // Firestore reference
    let db = Firestore.firestore()

    // Action for the Register Button
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let companyName = companyNameTextField.text, !companyName.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let role = roleTextField.text, !role.isEmpty else {
            displayAlert(message: "Please fill in all fields.")
            return
        }

        // Firebase Authentication: Create user
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.displayAlert(message: "Error: \(error.localizedDescription)")
                return
            }

            guard let userId = authResult?.user.uid else { return }

            // Save additional details in Firestore
            self.db.collection("companies").document(userId).setData([
                "companyName": companyName,
                "address": address,
                "role": role,
                "email": email
            ]) { error in
                if let error = error {
                    self.displayAlert(message: "Error saving company details: \(error.localizedDescription)")
                } else {
                    self.displayAlert(message: "Registration successful!", completion: {
                        // Navigate to login screen or main screen
                        self.dismiss(animated: true, completion: nil)
                    })
                }
            }
        }
    }

    // Helper to show alerts
    func displayAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
}
