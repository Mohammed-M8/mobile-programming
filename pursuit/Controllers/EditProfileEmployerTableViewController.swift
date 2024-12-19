//
//  EditProfileEmployerTableViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 17/12/2024.
//

import UIKit

class EditProfileEmployerTableViewController: UITableViewController {

    var profilePicture: String = ""
    var bgPicture: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var selectedGovernate: String = ""
    var profileDescription: String = ""
    private var isComingForBG = false
    var callBack: ((_ profilePicture: String, _ bgPicture: String, _ firstName: String, _ lastName: String, _ email: String, _ phoneNumber: String, _ selectedGovernate: String, _ profileDescription: String) -> Void)?
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
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phoneNumber.isEmpty || selectedGovernate.isEmpty || profileDescription.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter full profile details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        if let callBack {
            callBack(profilePicture, bgPicture, firstName, lastName, email, phoneNumber, selectedGovernate, profileDescription)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell, indexPath.section == 0 && indexPath.row == 0 {
            cell.bgImg.image = UIImage(named: self.bgPicture)
            cell.profileImg.image = UIImage(named: self.profilePicture)
            cell.bgImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlebgImgTap)))
            cell.profileImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImgTap)))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.height / 2
            })
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as? NameTableViewCell, indexPath.section == 0 && indexPath.row == 1 {
            cell.firstNameField.text = firstName
            cell.lastNameField.text = lastName
            cell.firstNameField.delegate = self
            cell.lastNameField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as? EmailTableViewCell, indexPath.section == 0 && indexPath.row == 2 {
            cell.emailField.text = email
            cell.emailField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as? PhoneTableViewCell, indexPath.section == 0 && indexPath.row == 3 {
            cell.phoneField.text = phoneNumber
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
        self.tableView.reloadData()
    }

}

extension EditProfileEmployerTableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        }
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil/*, onCancel: (target: Any, action: Selector)? = nil*/) {
//        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
//            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
//    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
