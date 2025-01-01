//
//  FilterPageViewController.swift
//  pursuit
//
//  Created by Mohammed Shahdad on 27/12/2024.
//

import UIKit

class FiltersPageViewController: UIViewController {

    
   @IBOutlet weak var filterBarBtn: UIBarButtonItem!
    
    
//    @IBOutlet var Types: [UIButton]!
//    @IBOutlet var Industry: [UIButton]!
//    @IBOutlet var Company: [UIButton]!
    
    
    @IBOutlet var Types: [UIButton]!
    
    @IBOutlet var Industry: [UIButton]!
    
    @IBOutlet var Company: [UIButton]!
    
    
    var selectedType: String?
    var selectedIndustry: String?
    var selectedCompany: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filterBarBtn.isEnabled = false
    }
    
    
    
    /*
    // this is the initial appearance
    func notSelectedButtonAppearance() {
        let allButtons = JobRoles + ExperienceLvl + Education + Certification
        for button in allButtons {
            button.backgroundColor = UIColor.secondarySystemFill
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.layer.cornerRadius = 20
        }
    }
    */
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let customColor = UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)
        let allButtons = Types + Industry + Company
        
        // Determine which group the sender belongs to
        let group: [UIButton]
        if Types.contains(sender) {
            group = Types
        } else if Industry.contains(sender) {
            group = Industry
        } else if Company.contains(sender) {
            group = Company
        }else{
            group = []
            print("Warning: sender is not in types, Industry, or Company.")
        }
        
        // For groups where only one selection is allowed (not including Certification)
        if group == Types || group == Industry || group == Company {
            for button in group {
                if button == sender {
                    // Toggle the sender's selection state
                    button.backgroundColor = button.backgroundColor == customColor ? UIColor.secondarySystemFill : customColor
                    button.setTitleColor(button.titleColor(for: .normal) == UIColor.white ? UIColor.lightGray : UIColor.white, for: .normal)
                } else {
                    // Deselect all other buttons in the group
                    button.backgroundColor = UIColor.secondarySystemFill
                    button.setTitleColor(UIColor.lightGray, for: .normal)
                }
            }
        } else {
            // For Certification, allow multiple selections
            sender.backgroundColor = sender.backgroundColor == customColor ? UIColor.secondarySystemFill : customColor
            sender.setTitleColor(sender.titleColor(for: .normal) == UIColor.white ? UIColor.lightGray : UIColor.white, for: .normal)
        }
        
        // Check if any filter button is selected to enable the filter bar button
        filterBarBtn.isEnabled = allButtons.contains { $0.backgroundColor == customColor }
        
        
        //sender.isSelected = !sender.isSelected
        //updateButtonAppearance(button: sender)
//        let customColor = UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)
//        
//        sender.backgroundColor = sender.backgroundColor == customColor ? UIColor.secondarySystemFill : customColor
//        sender.setTitleColor(sender.titleColor(for: .normal) == UIColor.white ? UIColor.lightGray : UIColor.white, for: .normal)
//        
//        var isAnyBtnSelected = false
//        let allButtons = JobRoles + ExperienceLvl + Education + Certification
//        for button in allButtons {
//            if button.backgroundColor == customColor {
//                isAnyBtnSelected = true
//                break
//            }
//        }
//        
//        filterBarBtn.isEnabled = isAnyBtnSelected
        updateSelectedFilters()
    }
    
    func updateSelectedFilters(){
        selectedType = Types.first(where: { $0.backgroundColor == UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0) })?.titleLabel?.text
        selectedIndustry = Industry.first(where: { $0.backgroundColor == UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0) })?.titleLabel?.text
        selectedCompany = Company.first(where: { $0.backgroundColor == UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0) })?.titleLabel?.text
    }
    
    /*
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
