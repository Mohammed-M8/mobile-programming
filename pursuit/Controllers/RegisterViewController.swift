//
//  RegisterViewController.swift
//  pursuit
//
//  Created by BP-36-201-07 User on 24/12/2024.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty
                       else {
                   displayAlert(message: "Please fill in all fields.")
                   return
               }
        
        // Firebase Authentication: Create user
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.displayAlert(message: "Error: \(error.localizedDescription)")
                        return
                    }

                    // Registration successful
                    self.displayAlert(message: "Registration Successful! You can now log in.") {
                        self.dismiss(animated: true)
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
