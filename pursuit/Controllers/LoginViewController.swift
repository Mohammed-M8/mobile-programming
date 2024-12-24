//
//  LoginViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // Outlets for your UITextFields
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!

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

                // Login successful
                self.displayAlert(message: "Login Successful!") {
                    // Navigate to the main screen or dismiss the login screen
                    self.performSegue(withIdentifier: "goToMainScreen", sender: nil)
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
    
    

    // Switch between register/login
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
}
