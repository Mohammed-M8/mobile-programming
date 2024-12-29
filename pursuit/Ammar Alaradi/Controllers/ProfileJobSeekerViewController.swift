//
//  ProfileJobSeekerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

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
    
    //    var skills: [Skills] = [Skills(title: "Problem Solving", percentage: "70"), Skills(title: "Programming Languages", percentage: "90"), Skills(title: "Team Collaboration", percentage: "60")]
    
    var profile: JobSeekerProfile?
    
    // Firestore reference
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2
        }
        self.fetchProfileData()
    }
    
    private func populateProfile() {
        guard let profile = self.profile else { return }
        self.profileImage = profile.profilePicture ?? ""
        self.profileImg.image =  self.profileImage.isEmpty ? UIImage(systemName: "person.circle") : UIImage(named: self.profileImage)
        self.bgImage = profile.bgPicture ?? ""
        self.bgImg.image = self.bgImage.isEmpty ? UIImage(systemName: "person.and.background.striped.horizontal") : UIImage(named: self.bgImage)
        self.firstNameLbl.text = profile.firstName ?? "----"
        self.lastNameLbl.text = profile.lastName ?? "----"
        self.profileDescriptionLbl.text = profile.profileDescription ?? "No Description"
        self.emailLbl.text = profile.email ?? "----"
        self.phoneNmberLbl.text = profile.phoneNumber ?? "----"
        self.governateLbl.text = profile.governate ?? "----"
        
        self.skillsStackView.forEach({ stackView in
            stackView.isHidden = true
        })
        
        let profileSkills = profile.skills ?? []
        let skillsCount = (profileSkills.count - 1)
        if skillsCount >= 0 {
            for index in 0...skillsCount {
                self.skillsStackView[index].isHidden = false
                self.skillsLbl[index].text = profileSkills[index].title
                self.percentageLbl[index].text = profileSkills[index].percentage
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
            editProfileJobSeekerTableViewController.selectedGovernate = (governateLbl.text?.allSatisfy({$0 == "-"}) ?? true) ? "" : (governateLbl.text ?? "").components(separatedBy: ",").first ?? ""
            editProfileJobSeekerTableViewController.skills = profile?.skills ?? []
            editProfileJobSeekerTableViewController.callBack = { [weak self] (profile) in
                self?.profile = profile
                self?.populateProfile()
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
    
    @IBAction func LogoutTapped(_ sender: Any) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Logout",
                                                message: "Are you sure you want to logout?",
                                                preferredStyle: .alert)
        
        // Create Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Do nothing, just dismiss the alert
        }
        
        // Create Logout action
        let logoutAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            // Perform the segue to Login screen
            self.performSegue(withIdentifier: "LogoutJobSeeker", sender: nil)
        }
        
        // Add both actions to alert controller
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        // Present the alert
        present(alertController, animated: true)
        
        
    }
    
    func fetchProfileData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("jobSeeker").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                if let user = try? document.data(as: JobSeekerProfile.self) {
                    self.profile = user
                    self.populateProfile()
                } else {
                    let error = NSError(domain: "FirebaseServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Profile not found."])
                    print("Profile error :: ", error.localizedDescription)
                }
            } else {
                let error = NSError(domain: "FirebaseServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Profile not found."])
                print("Profile error :: ", error.localizedDescription)
            }
        }
    }
    
}
