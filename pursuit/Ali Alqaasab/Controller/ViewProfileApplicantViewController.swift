//
//  ViewProfileApplicantViewController.swift
//  pursuit
//
//  Created by Ali Alqassab on 26/12/2024.
//

import UIKit

class ViewProfileApplicantViewController: UIViewController {
    var applicantData: JobApplication?
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var applicantDescription: UILabel!
    @IBOutlet weak var applicantEmail: UILabel!
    @IBOutlet weak var applicantPhone: UILabel!
    @IBOutlet weak var applicantGovernate: UILabel!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var viewCV: UIButton!
    @IBOutlet var skillsStackView: [UIStackView]!
    @IBOutlet var skillsLbl: [UILabel]!
    @IBOutlet var percentageLbl: [UILabel]!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    @IBOutlet weak var pending: UIButton!
    @IBOutlet weak var Accepted: UIButton!
    @IBOutlet weak var Rejected: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBarButton.isEnabled = false
        
        let allButtons = [pending, Accepted, Rejected]
            allButtons.forEach { button in
                button?.layer.cornerRadius = 10 // Adjust corner radius as needed
                button?.layer.masksToBounds = true
            }
        
        selectButton(pending)

        // Do any additional setup after loading the view.
        
        guard let data = applicantData else { return }
            
            fName.text = data.firstName
            lName.text = data.lastName
        applicantEmail.text = data.ApplicationJobSeeker.Email
        applicantPhone.text = data.ApplicationJobSeeker.JobSeekerCv.phoneNumber
        applicantGovernate.text = data.ApplicationJobSeeker.JobSeekerCv.Location
        applicantDescription.text = data.ApplicationJobSeeker.Description
        profileImg.image = UIImage(named: data.ApplicationJobSeeker.pfpName) ?? UIImage(systemName: "person.crop.circle.fill")
        
        // Make the profile image circular
            profileImg.layer.cornerRadius = 69
            profileImg.layer.masksToBounds = true
            profileImg.clipsToBounds = true
        
    }
    
    func selectButton(_ selectedButton: UIButton) {
        let customColor = UIColor(red: 24/255.0, green: 116/255.0, blue: 148/255.0, alpha: 1.0)
        // Reset styles for all buttons
        let allButtons = [pending, Accepted, Rejected]
        allButtons.forEach { button in
            button?.backgroundColor = .systemGray5
            button?.setTitleColor(.black, for: .normal)
            button?.isSelected = false
        }

        // Apply selected styles
        selectedButton.backgroundColor = customColor
        selectedButton.setTitleColor(.white, for: .normal)
        selectedButton.isSelected = true

        // Enable Save button only if the selected button is NOT Pending
        saveBarButton.isEnabled = selectedButton != pending
    }
    
    @IBAction func pendingButtonTapped(_ sender: UIButton) {
        selectButton(sender)
    }

    @IBAction func acceptedButtonTapped(_ sender: UIButton) {
        selectButton(sender)
    }

    @IBAction func rejectedButtonTapped(_ sender: UIButton) {
        selectButton(sender)
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
