//
//  ProfileEmployerViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 16/12/2024.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        editProfileEmployerTableViewController.selectedGovernate = (governateLbl.text ?? "").components(separatedBy: ",").first ?? ""
        editProfileEmployerTableViewController.callBack = { [weak self] (profilePicture, bgPicture, firstName, lastName, email, phoneNumber, selectedGovernate, profileDescription) in
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
    
}
