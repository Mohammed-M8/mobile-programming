//
//  GuestTabBarViewController.swift
//  pursuit
//
//  Created by BP-36-212-04 on 28/12/2024.
//

import UIKit

class GuestTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension GuestTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Check if the selected tab is the Profile tab
        if let navController = viewController as? UINavigationController,
           navController.viewControllers.first is GuestViewController {
            showGuestAlert()
            return false
        }
        return true
    }
    
    private func showGuestAlert() {
        let alert = UIAlertController(
            title: "Registration Required",
            message: "Please sign in or create an account to access your profile",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { //[weak self]
            _ in
            //self?.navigateToSignIn()
        }))
        
        present(alert, animated: true)
    }
    
    /*private func navigateToSignIn() {
        if let signInVC = storyboard?.instantiateViewController(withIdentifier: "RegScreen") {
            signInVC.modalPresentationStyle = .fullScreen
            present(signInVC, animated: true)
        }
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
