//
//  EditProfileEmployerTableViewController.swift
//  pursuit
//
//  Created by BP-36-201-05 on 17/12/2024.
//

import UIKit

class EditProfileEmployerTableViewController: UITableViewController {

    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phone: String = ""
    var selectedGovernate: String = ""
    var profileDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let nib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProfileTableViewCell")
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

    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        
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
//            cell.bgImg.backgroundColor = .blue
//            cell.profileImg.backgroundColor = .white
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as? NameTableViewCell, indexPath.section == 0 && indexPath.row == 1 {
            cell.firstNameField.text = "Ahmed"
            cell.lastNameField.text = "Elshabab"
            cell.firstNameField.delegate = self
            cell.lastNameField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "EmailTableViewCell", for: indexPath) as? EmailTableViewCell, indexPath.section == 0 && indexPath.row == 2 {
            cell.emailField.text = "ahmed@gmail.com"
            cell.emailField.delegate = self
            return cell
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneTableViewCell", for: indexPath) as? PhoneTableViewCell, indexPath.section == 0 && indexPath.row == 3 {
            cell.phoneField.text = "0123456789"
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
            
            cell.descriptionField.text = "Description"
            cell.descriptionField.delegate = self
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
            self.phone = textField.text ?? ""
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
