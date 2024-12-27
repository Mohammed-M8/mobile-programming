//
//  ProfileJobSeekerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import UIKit

class ProfileJobSeekerViewController: UIViewController {
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var profileDescriptionLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNmberLbl: UILabel!
    @IBOutlet weak var governateLbl: UILabel!
    @IBOutlet var skillsStackView: [UIStackView]!
    @IBOutlet var skillsLbl: [UILabel]!
    @IBOutlet var percentageLbl: [UILabel]!
    
    var profileImage = "profile6"
    var bgImage = "background6"
    
    var skills: [Skills] = [Skills(title: "Problem Solving", percentage: "70"), Skills(title: "Programming Languages", percentage: "90"), Skills(title: "Team Collaboration", percentage: "60")]

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2
        }
        self.populateSkills()
    }
    
    private func populateSkills() {
        self.skillsStackView.forEach({ stackView in
            stackView.isHidden = true
        })
        
        let skillsCount = (skills.count - 1)
        if skillsCount >= 0 {
            for index in 0...skillsCount {
                self.skillsStackView[index].isHidden = false
                self.skillsLbl[index].text = skills[index].title
                self.percentageLbl[index].text = skills[index].percentage
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editProfileJobSeekerTableViewController = segue.destination as? EditProfileJobSeekerTableViewController {
            editProfileJobSeekerTableViewController.profilePicture = profileImage
            editProfileJobSeekerTableViewController.bgPicture = bgImage
            editProfileJobSeekerTableViewController.firstName = firstNameLbl.text ?? ""
            editProfileJobSeekerTableViewController.lastName = lastNameLbl.text ?? ""
            editProfileJobSeekerTableViewController.profileDescription = profileDescriptionLbl.text ?? ""
            editProfileJobSeekerTableViewController.email = emailLbl.text ?? ""
            editProfileJobSeekerTableViewController.phoneNumber = phoneNmberLbl.text ?? ""
            editProfileJobSeekerTableViewController.selectedGovernate = (governateLbl.text ?? "").components(separatedBy: ",").first ?? ""
            editProfileJobSeekerTableViewController.skills = skills
            editProfileJobSeekerTableViewController.callBack = { [weak self] (profilePicture, bgPicture, firstName, lastName, email, phoneNumber, selectedGovernate, profileDescription, skills) in
                self?.profileImage = profilePicture
                self?.profileImg.image = UIImage(named: profilePicture)
                self?.bgImage = bgPicture
                self?.bgImg.image = UIImage(named: bgPicture)
                self?.firstNameLbl.text = firstName
                self?.lastNameLbl.text = lastName
                self?.profileDescriptionLbl.text = profileDescription
                self?.emailLbl.text = email
                self?.phoneNmberLbl.text = phoneNumber
                self?.governateLbl.text = "\(selectedGovernate), Bahrain"
                self?.skills = skills
                self?.populateSkills()
            }
        } else if let applicationTrackerViewController = segue.destination as? ApplicationTrackerViewController {
            applicationTrackerViewController.firstName = firstNameLbl.text ?? ""
            applicationTrackerViewController.lastName = lastNameLbl.text ?? ""
            applicationTrackerViewController.profileImage = profileImage
        }
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfileSegue", sender: self)
    }
    
    @IBAction func applicationTrackerTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "applicationTracker", sender: self)
    }

}
