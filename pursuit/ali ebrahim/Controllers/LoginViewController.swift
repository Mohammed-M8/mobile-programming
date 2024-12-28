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
        @IBAction func loginButtonTapped(_ sender: Any) {
            guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty else {
                displayAlert(message: "Please fill in all fields.")
                return
            }
            // Firebase Authentication: Sign in user
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.displayAlert(message: "Error: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "ContentPersonalization", bundle: nil)
                    if let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController {
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                }

           
                
            
            }
        }
    // Login successful
   /* self.displayAlert(message: "Login Successful!") {
        // Navigate to the main screen or dismiss the login screen
        self.performSegue(withIdentifier: "HomeJobS", sender: nil)
    } */

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
    
    
    // Action for the Guest Login Button
        @IBAction func guestLoginButtonTapped(_ sender: UIButton) {
            // Step 1: Create the alert
            let alert = UIAlertController(
                title: "Guest Login",
                message: "Guest login provides limited access to the content. Are you sure you want to continue as a guest.",
                preferredStyle: .alert
            )

            // Step 2: Add "Register" button
            alert.addAction(UIAlertAction(title: "Register", style: .default, handler: { _ in
                // Go back or dismiss the alert (stay on the current screen)
                print("Register button tapped")
            }))

            // Step 3: Add "Continue" button
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                // Navigate to the guest home page
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "BaseGuest", bundle: nil)
                    if let tabBarController = storyboard.instantiateViewController(withIdentifier: "BaseGuest") as? UITabBarController {
                                tabBarController.modalPresentationStyle = .fullScreen
                        self.present(tabBarController, animated: true, completion: nil)
                    }
                }

            }))

            // Step 4: Present the alert
            self.present(alert, animated: true, completion: nil)
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
