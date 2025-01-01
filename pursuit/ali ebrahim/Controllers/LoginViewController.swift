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
            
            // If sign in is successful, present the ContentPersonalization storyboard
            DispatchQueue.main.async {
                // 1. Create a reference to the ContentPersonalization storyboard
                let storyboard = UIStoryboard(name: "ContentPersonalization", bundle: nil)
                
                // 2. Instantiate the view controller by its Storyboard ID, e.g. "ContentPersonalization"
                    let contentVC = storyboard.instantiateViewController(withIdentifier: "ContentPersonalization")
                    // 3. Present it full-screen (so the user can’t swipe to dismiss, if you prefer)
                    contentVC.modalPresentationStyle = .fullScreen
                    self.present(contentVC, animated: true, completion: nil)
                
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
        // Additional setup if needed
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
        let alert = UIAlertController(
            title: "Guest Login",
            message: "Guest login provides limited access to the content. Are you sure you want to continue as a guest?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Register", style: .default, handler: { _ in
            print("Register button tapped")
        }))

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

        self.present(alert, animated: true, completion: nil)
    }
}
