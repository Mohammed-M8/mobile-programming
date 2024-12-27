//
//  AdminLoginViewController.swift
//  pursuit
//
//  Created by BP-36-201-01 User on 25/12/2024.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class AdminLoginViewController: UIViewController {

    // Outlets for login ID and password text fields
    @IBOutlet weak var loginIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // Firestore reference
    let db = Firestore.firestore()

    // Action for the Admin Login Button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let loginID = loginIDTextField.text, !loginID.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            displayAlert(message: "Please fill in all fields.")
            return
        }

        // Step 1: Retrieve email associated with the login ID from Firestore
        db.collection("admins").document(loginID).getDocument { document, error in
            if let error = error {
                self.displayAlert(message: "Error fetching admin details: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists,
                  let email = document.data()?["email"] as? String,
                  let isAdmin = document.data()?["isAdmin"] as? Bool, isAdmin else {
                self.displayAlert(message: "Invalid login ID or unauthorized access.")
                return
            }

            // Step 2: Authenticate the admin using the retrieved email and password
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.displayAlert(message: "Error: \(error.localizedDescription)")
                    return
                }
                // Step 3: Navigate to the admin dashboard
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "BaseAdmin", bundle: nil)
                        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "BaseAdmin") as? UITabBarController {
                                    tabBarController.modalPresentationStyle = .fullScreen
                            self.present(tabBarController, animated: true, completion: nil)
                        }
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
