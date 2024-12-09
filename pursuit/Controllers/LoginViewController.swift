//
//  LoginViewController.swift
//  pursuit
//
//  Created by BP-36-201-17 on 28/11/2024.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var loginSegmentedView: UIView!
    
    
    @IBOutlet weak var registerSegmentedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.bringSubviewToFront(registerSegmentedView)
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
