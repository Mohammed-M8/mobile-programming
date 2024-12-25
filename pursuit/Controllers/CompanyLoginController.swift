//
//  CompanyLoginController.swift
//  pursuit
//
//  Created by BP-36-201-10 on 10/12/2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CompanyLoginController: UIViewController {
    
    // Outlets for your UITextFields
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!

        // Firestore reference
        let db = Firestore.firestore()

        // Action for the Login Button
        @IBAction func loginButtonTapped(_ sender: UIButton) {
            guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                displayAlert(message: "Please fill in all fields.")
                return
            }

            // Firebase Authentication: Sign in user
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.displayAlert(message: "Error: \(error.localizedDescription)")
                    return
                }

                guard let userId = authResult?.user.uid else { return }

                // Fetch company details from Firestore (optional)
                self.db.collection("companies").document(userId).getDocument { document, error in
                    if let error = error {
                        self.displayAlert(message: "Error fetching company details: \(error.localizedDescription)")
                    } else if let document = document, document.exists {
                        let companyData = document.data()
                        print("Company Data: \(companyData ?? [:])")

                        self.displayAlert(message: "Login successful!") {
                            // Navigate to the main screen
                            self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
                        }
                    } else {
                        self.displayAlert(message: "No company details found.")
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
    
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var loginSegmentedView: UIView!
    
    
    @IBOutlet weak var registerSegmentedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //self.view.bringSubviewToFront(registerSegmentedView)
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(registerSegmentedView)
        case 1:
            self.view.bringSubviewToFront(loginSegmentedView)
        default:
            break
        }
    }
}
