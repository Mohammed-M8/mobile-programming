//
//  FilterPageViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 23/12/2024.
//

import UIKit

class FilterPageViewController: UIViewController {

    @IBOutlet var JobRoles: [UIButton]!
    @IBOutlet var ExperienceLvl: [UIButton]!
    @IBOutlet var Education: [UIButton]!
    @IBOutlet var Certification: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notSelectedButtonAppearance()
    }
    
    // this is the initial appearance
    func notSelectedButtonAppearance() {
        let allButtons = JobRoles + ExperienceLvl + Education + Certification
        for button in allButtons {
            button.backgroundColor = UIColor.secondarySystemFill
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.layer.cornerRadius = 20
        }
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updateButtonAppearance(button: sender)
        
        
    }
    
    //func to update appearance
    func updateButtonAppearance(button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)
            button.setTitleColor(UIColor.white, for: .normal)
        } else {
            button.backgroundColor = UIColor.secondarySystemFill
            button.setTitleColor(UIColor.lightGray, for: .normal)
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
