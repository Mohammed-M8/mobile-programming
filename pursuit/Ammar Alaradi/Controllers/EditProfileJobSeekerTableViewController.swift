//
//  EditProfileJobSeekerTableViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 23/12/2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditProfileJobSeekerTableViewController: UITableViewController {
    
    var profilePicture: String = ""
    var bgPicture: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var selectedGovernate: String = ""
    var profileDescription: String = ""
    var skills: [JobSeekerSkills] = []
    private var isComingForBG = false
    private var governate: [String] = ["The Capital", "Northern", "Southern", "Muharraq"]
    var callBack: ((_ jobSeekerProfile: JobSeekerProfile) -> Void)?
    // Firestore reference
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let profileNib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(profileNib, forCellReuseIdentifier: "ProfileTableViewCell")
        let nameNib = UINib(nibName: "NameTableViewCell", bundle: nil)
        tableView.register(nameNib, forCellReuseIdentifier: "NameTableViewCell")
        let emailNib = UINib(nibName: "EmailTableViewCell", bundle: nil)
        tableView.register(emailNib, forCellReuseIdentifier: "EmailTableViewCell")
        let phoneNib = UINib(nibName: "PhoneTableViewCell", bundle: nil)
        tableView.register(phoneNib, forCellReuseIdentifier: "PhoneTableViewCell")
        let governateNib = UINib(nibName: "GovernateTableViewCell", bundle: nil)
        tableView.register(governateNib, forCellReuseIdentifier: "GovernateTableViewCell")
        let descriptionNib = UINib(nibName: "DescriptionTableViewCell", bundle: nil)
        tableView.register(descriptionNib, forCellReuseIdentifier: "DescriptionTableViewCell")
        let skillsNib = UINib(nibName: "SkillsTableViewCell", bundle: nil)
        tableView.register(skillsNib, forCellReuseIdentifier: "SkillsTableViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let choosePictureViewController = segue.destination as? ChoosePictureViewController else { return }
        choosePictureViewController.isComingForBG = isComingForBG
        choosePictureViewController.callBack = { [weak self] picture in
            if let isComingForBG = self?.isComingForBG {
                if isComingForBG {
                    self?.bgPicture = picture
                } else {
                    self?.profilePicture = picture
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
        let filteredSkills = skills.filter { !$0.title.isEmpty }
        if (firstName.isEmpty || firstName.allSatisfy({ $0 == "-" })) || (lastName.isEmpty || lastName.allSatisfy({ $0 == "-" })) || email.isEmpty || (phoneNumber.isEmpty || phoneNumber.allSatisfy({ $0 == "-" })) || selectedGovernate.isEmpty || profileDescription.isEmpty || filteredSkills.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter full profile details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        } else if !self.isValidEmail(text: email) {
            let alert = UIAlertController(title: "Error", message: "Please enter valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        skills = filteredSkills
        self.setJobSeekerProfile()
    }
    
    /// Add or Update user data to Firestore
    func setJobSeekerProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let selectedGovernate = "\(self.selectedGovernate), Bahrain"
        let jobSeekerProfile: JobSeekerProfile = JobSeekerProfile(firstName: firstName, lastName: lastName, profilePicture: profilePicture, bgPicture: bgPicture, email: email, phoneNumber: phoneNumber, profileDescription: profileDescription, governate: selectedGovernate, skills: skills)
        guard let encodedUser = try? Firestore.Encoder().encode(jobSeekerProfile) else { return }
        db.collection("jobSeeker").document(userId).setData(encodedUser, merge: true) { error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: "Error saving profile data", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Profile Updated Successfully", message: "Your profile has been updated and saved successfully!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                    if let callBack = self.callBack {
                        callBack(jobSeekerProfile)
                        self.navigationController?.popViewController(animated: true)
                    }
                }))
                self.present(alert, animated: true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell, indexPath.section == 0 && indexPath.row == 0 {
            cell.bgImg.image = self.bgPicture.isEmpty ? UIImage(systemName: "person.and.background.striped.horizontal") : UIImage(named: self.bgPicture)
            cell.profileImg.image = self.profilePicture.isEmpty ? UIImage(systemName: "person.circle") : UIImage(named: self.profilePicture)
            cell.bgImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlebgImgTap)))
            cell.profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImgTap)))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.height / 2
            })
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as? NameTableViewCell, indexPath.section == 0 && indexPath.row == 1 {
            if !firstName.allSatisfy({ $0 == "-" }) {
                cell.firstNameField.text = firstName
            }
            if !lastName.allSatisfy({ $0 == "-" }) {
                cell.lastNameField.text = lastName
            }
            cell.firstNameField.delegate = self
            cell.lastNameField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as? EmailTableViewCell, indexPath.section == 0 && indexPath.row == 2 {
            cell.emailField.text = email
            cell.emailField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as? PhoneTableViewCell, indexPath.section == 0 && indexPath.row == 3 {
            if !phoneNumber.allSatisfy({ $0 == "-" }) {
                cell.phoneField.text = phoneNumber
            }
            cell.phoneField.delegate = self
            cell.phoneField.addDoneCancelToolbar()
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "GovernateTableViewCell", for: indexPath) as? GovernateTableViewCell, indexPath.section == 0 && indexPath.row == 4 {
            cell.parentView.layer.cornerRadius = 12.0
            cell.parentView.layer.borderColor = UIColor.gray.cgColor
            cell.parentView.layer.borderWidth = 1
            cell.parentView.clipsToBounds = true
            
            cell.dropDownCallBack = {
                cell.dropDownView.isHidden.toggle()
                cell.dropDownImg.image = UIImage(systemName: "\( cell.dropDownView.isHidden ? "chevron.down" : "chevron.up")")
                tableView.reloadData()
            }
            cell.dropDownOptionSelected = { [weak self] tag in
                self?.dropDownselected(cell: cell, tag: tag)
            }
            
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as? DescriptionTableViewCell, indexPath.section == 0 && indexPath.row == 5 {
            cell.parentView.layer.cornerRadius = 12.0
            cell.parentView.layer.borderColor = UIColor.gray.cgColor
            cell.parentView.layer.borderWidth = 1
            cell.parentView.clipsToBounds = true
            
            cell.descriptionField.text = profileDescription
            cell.descriptionField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: indexPath) as? SkillsTableViewCell, indexPath.section == 0 && indexPath.row == 6 {
            cell.parentView.layer.cornerRadius = 12.0
            cell.parentView.layer.borderColor = UIColor.gray.cgColor
            cell.parentView.layer.borderWidth = 1
            cell.parentView.clipsToBounds = true
            
            cell.skillsView.forEach { skillView in
                skillView.layer.cornerRadius = 12.0
                skillView.layer.borderColor = UIColor.gray.cgColor
                skillView.layer.borderWidth = 1
                skillView.clipsToBounds = true
            }
            
            cell.percentageView.forEach { percentageView in
                percentageView.layer.cornerRadius = 12.0
                percentageView.layer.borderColor = UIColor.gray.cgColor
                percentageView.layer.borderWidth = 1
                percentageView.clipsToBounds = true
            }
            
            cell.skillsField.forEach { skillsField in
                skillsField.delegate = self
            }
            
            cell.percentageField.forEach { percentageField in
                percentageField.delegate = self
            }
            
            let skillsCount = (skills.count - 1)
            if skillsCount >= 0 {
                for index in 0...skillsCount {
//                    if !skills[index].title.isEmpty {
                        cell.skillsStackView[index].isHidden = false
                        cell.skillsField[index].text = skills[index].title
                        cell.percentageField[index].text = skills[index].percentage
//                    }
                }
            }
            
            cell.addSkillCallBack = { [weak self] in
                print("addSkillCallBack")
                self?.addSkillsTapped(cell: cell)
            }
            
            cell.removeSkillCallBack = { [weak self] tag in
                cell.skillsStackView.forEach({ stackView in
                    stackView.isHidden = true
                })
                self?.skills.remove(at: tag)
                tableView.reloadData()
                print("removeSkillCallBack :: ", tag)
            }
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    @objc func handleProfileImgTap(_ sender: Any) {
        print("handleProfileImgTap")
        self.isComingForBG = false
        self.performSegue(withIdentifier: "choosePicture", sender: self)
    }
    
    @objc func handlebgImgTap(_ sender: Any) {
        print("handlebgImgTap")
        self.isComingForBG = true
        self.performSegue(withIdentifier: "choosePicture", sender: self)
    }
    
    @objc func doneButtonTappedForMyNumericTextField(_ sender: Any) {
        print("Done ")
        self.view.endEditing(true)
    }
    
    private func dropDownselected (cell: GovernateTableViewCell, tag: Int) {
        for index in 0..<cell.dropDownImages.count {
            cell.dropDownImages[index].image = UIImage(systemName: "\(tag == index ? "circle.fill" : "circle")")
        }
        self.selectedGovernate = self.governate[tag]
        self.tableView.reloadData()
    }
    
    private func isValidEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return emailTest.evaluate(with: trimmedText)
    }
    
    private func addSkillsTapped(cell: SkillsTableViewCell) {
        if (skills.count - 1) < 2 {
            skills.append(JobSeekerSkills(title: "", percentage: ""))
            cell.skillsStackView[skills.count - 1].isHidden = false
            self.tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Limit Reached", message: "You can only add up to 3 skills.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

}

extension EditProfileJobSeekerTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.placeholder == "First Name" {
            self.firstName = textField.text ?? ""
        } else if textField.placeholder == "Last Name" {
            self.lastName = textField.text ?? ""
        } else if textField.placeholder == "Email Address" {
            self.email = textField.text ?? ""
        } else if textField.placeholder == "Phone Number" {
            self.phoneNumber = textField.text ?? ""
        } else if textField.placeholder == "Please enter your description" {
            self.profileDescription = textField.text ?? ""
        } else if textField.placeholder == "Enter Skill" {
            self.skills[textField.tag].title = textField.text ?? ""
        } else if textField.placeholder == "%" {
            self.skills[textField.tag].percentage = textField.text ?? ""
        }
    }
}
