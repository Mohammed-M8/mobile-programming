//
//  CompanyLoginController.swift
//  pursuit
//
//  Created by BP-36-201-10 on 10/12/2024.
//

import UIKit

class CompanyLoginController: UIViewController {
    
    
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
}
