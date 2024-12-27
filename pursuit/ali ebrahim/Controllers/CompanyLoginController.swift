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
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                
                if let error = error {
                                print("Login error: \(error.localizedDescription)") // Debug print
                                self.displayAlert(message: "Error: \(error.localizedDescription)")
                                return
                }
                
                guard let userId = authResult?.user.uid else { return }

                // Fetch company details from Firestore (optional)
                self.db.collection("companies").document(userId).getDocument { [weak self] document, error in
                            guard let self = self else { return }
                            
                            if let error = error {
                                self.displayAlert(message: "Error fetching company details: \(error.localizedDescription)")
                                return
                            }
                            
                            if let document = document, document.exists {
                                // This is a valid company account
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "BaseEmployer", bundle: nil)
                                    
                                    // Use instantiateInitialViewController instead of specific identifier
                                    if let tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController {
                                        tabBarController.modalPresentationStyle = .fullScreen
                                        
                                        // Set as root view controller
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = windowScene.windows.first {
                                            window.rootViewController = tabBarController
                                            UIView.transition(with: window,
                                                              duration: 0.3,
                                                              options: .transitionCrossDissolve,
                                                              animations: nil,
                                                              completion: nil)
                                        }
                                    } else {
                                        print("Failed to load tab bar controller")
                                        self.displayAlert(message: "Error loading employer interface")
                                    }
                                }
                    } else {
                        self.displayAlert(message: "This account is not registered as a company.")
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
