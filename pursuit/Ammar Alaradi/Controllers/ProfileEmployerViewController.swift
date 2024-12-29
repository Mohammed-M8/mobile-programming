//
//  ProfileEmployerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 16/12/2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileEmployerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var profileDescriptionLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNmberLbl: UILabel!
    @IBOutlet weak var governateLbl: UILabel!
    @IBOutlet weak var PostApplicationTable: UITableView!
    
    var profileImage = "profile1"
    var bgImage = "background1"
    var tableData = [Applications]()
    
    var profile: EmployerProfile?
    
    // Firestore reference
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchProfileData()
        
        tableData = [Applications(title: "Software Engineer", description: "Develop and maintain software applications, focusing on enhancing user experience and functionality.", date: "posted 12 hours ago", image: ""),
                     Applications(title: "Network Engineer", description: "Optimize network performance and troubleshoot connectivity issues to ensure seamless service delivery.", date: "posted 16 hours ago", image: ""),
                     Applications(title: "Sales Executive", description: "Promote Zain’s products and services to customers and achieve sales targets.", date: "posted 1 day ago", image: ""),
                     Applications(title: "Call Centre Representative", description: "Deliver excellent customer service by addressing inquiries and resolving issues.", date: "posted 1 day ago", image: "")]
        let nib = UINib(nibName: "PostApplicationTableViewCell", bundle: nil)
        PostApplicationTable.register(nib, forCellReuseIdentifier: "PostApplication")
        PostApplicationTable.estimatedRowHeight = UITableView.automaticDimension
        PostApplicationTable.dataSource = self
        PostApplicationTable.delegate = self
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
    }
    
    override func viewDidLayoutSubviews() {
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editProfileEmployerTableViewController = segue.destination as? EditProfileEmployerTableViewController else { return }
        editProfileEmployerTableViewController.profilePicture = profileImage
        editProfileEmployerTableViewController.bgPicture = bgImage
        editProfileEmployerTableViewController.firstName = firstNameLbl.text ?? ""
        editProfileEmployerTableViewController.lastName = lastNameLbl.text ?? ""
        editProfileEmployerTableViewController.profileDescription = profileDescriptionLbl.text ?? ""
        editProfileEmployerTableViewController.email = emailLbl.text ?? ""
        editProfileEmployerTableViewController.phoneNumber = phoneNmberLbl.text ?? ""
        editProfileEmployerTableViewController.selectedGovernate = (governateLbl.text?.allSatisfy({$0 == "-"}) ?? true) ? "" : (governateLbl.text ?? "").components(separatedBy: ",").first ?? ""
        editProfileEmployerTableViewController.address = profile?.address ?? ""
        editProfileEmployerTableViewController.companyName = profile?.companyName ?? ""
        editProfileEmployerTableViewController.role = profile?.role ?? ""
        editProfileEmployerTableViewController.callBack = { [weak self] (profile) in
            self?.profile = profile
            self?.populateProfile()
        }
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "editEmployerProfileSegue", sender: self)
    }
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostApplication") as! PostApplicationTableViewCell
        let data = tableData[indexPath.row]
        cell.JobTitle.text = data.title
        cell.JobDescription.text = data.description
        cell.DatePosted.text = data.date
        return cell
    }
    
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
                self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
            }
            
            // Add both actions to alert controller
            alertController.addAction(cancelAction)
            alertController.addAction(logoutAction)
            
            // Present the alert
            present(alertController, animated: true)
        
    }
    
    func fetchProfileData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        db.collection("companies").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                if let user = try? document.data(as: EmployerProfile.self) {
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
